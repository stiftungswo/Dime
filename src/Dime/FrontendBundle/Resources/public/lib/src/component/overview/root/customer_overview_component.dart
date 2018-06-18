import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../pipe/filter_pipe.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/http_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/copy_input_component.dart';
import '../../common/dime_directives.dart';
import '../../select/select.dart';
import '../entity_overview.dart';

@Component(
    selector: 'customer-overview',
    templateUrl: 'customer_overview_component.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, TagSelectComponent, CopyInputComponent],
    pipes: const [dimePipes, ProjectOverviewFilterPipe])
class CustomerOverviewComponent extends EntityOverview<Customer> implements OnActivate {
  CustomerOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, RouteParams prov, EntityEventsService entityEventsService, this.http, this.sanitizationService)
      : super(Customer, store, 'CustomerEdit', manager, status, entityEventsService, auth: auth, router: router);

  static String globalFilterString = '';
  static List<Tag> filterTags = [];
  static bool showOnlySystemCustomer = false;
  bool importExportOpen = false;
  List<Customer> customersToImport = [];

  HttpService http;
  DomSanitizationService sanitizationService;

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Kunden');
    reload();
  }

  @override
  String sortType = "name";

  @override
  Customer cEnt({Customer entity}) {
    if (entity != null) {
      return new Customer.clone(entity);
    }
    return new Customer();
  }

  String getEmailString() {
    var filterPipe = new FilterPipe();
    var projectFilterPipe = new ProjectOverviewFilterPipe();
    var tmpList = filterPipe.transform(this.entities, ['id', 'name', 'address'], globalFilterString);
    return projectFilterPipe
        .transform(tmpList, filterTags, showOnlySystemCustomer)
        .where((Customer c) => c.email?.isNotEmpty ?? false)
        .map((Customer c) => "${c.name}<${c.email}>")
        .join(',');
  }

  String getCsvExportLink() {
    var params = {
      "search": globalFilterString,
      "withTags": filterTags.map((t) => t.id).join(","),
      "systemCustomer": showOnlySystemCustomer ? "1" : "0",
    };
    String query = encodeQueryParams(params);
    return '${http.baseUrl}/customers/export/csv${query}';
  }

  importFile(FileList files) async {
    if (files.length != 1) {
      return;
    }
    File file = files.single;

    String fileContent = await readFileToString(file);
    print(fileContent);
    List<Customer> customers = parseCsv(fileContent);
    print(customers);
    customersToImport = customers;
  }

  static Future<String> readFileToString(File file) {
    Completer<String> completer = new Completer();
    FileReader reader = new FileReader();
    reader.onLoad.listen((ProgressEvent e) {
      FileReader eventTarget = e.target as FileReader;
      if (eventTarget.readyState != FileReader.DONE) return;
      if (eventTarget.error != null) {
        completer.completeError('Error while reading file');
        return;
      }

      completer.complete(eventTarget.result);
    });
    reader.readAsText(file, 'ISO-8859-1');

    return completer.future;
  }

  static const CSV_HEADER = const [
    'Beschreibung',
    'Firma',
    'Abteilung',
    'Anrede',
    'E-Mail',
    'Telefonnummer',
    'Ansprechperson',
    'Strasse',
    'Adresszusatz',
    'Postleitzahl',
    'Stadt',
    'Land'
  ];
  static List<Customer> parseCsv(String input) {
    const d = const FirstOccurrenceSettingsDetector(
      eols: const ['\r\n', '\n', '\r'],
      textDelimiters: const ['"', "'"],
      fieldDelimiters: const [',', ';'],
    );
    const converter = const CsvToListConverter(
      shouldParseNumbers: false,
      csvSettingsDetector: d,
      allowInvalid: true,
    );
    List<List<dynamic>> rows = converter.convert(input);

    if (rows.isNotEmpty && rows.first.isNotEmpty && rows.first.first == 'sep=') {
      // skip excel seperator mark
      rows = rows.sublist(1);
    }
    if (rows.isNotEmpty && rows.first.join() == CSV_HEADER.join()) {
      // skip csv header
      rows = rows.sublist(1);
    }

    if (rows.isEmpty || rows.first.length != CSV_HEADER.length) {
      return [];
    }

    return rows.map((List<dynamic> row) {
      Customer customer = new Customer()
            ..name = row[0]
            ..company = row[1]
            ..department = row[2]
            ..salutation = row[3]
            ..email = row[4]
            ..phone = row[5]
            ..fullname = row[6]
          //..chargeable = /*get from form*/
          //..systemCustomer = /*get from form*/
          ;
      customer.address = new Address()
        ..street = row[7]
        ..supplement = row[8]
        ..plz = int.parse(row[9])
        ..city = row[10]
        ..country = row[11];
      return customer;
    }).toList();
  }

  SafeUrl getCsvTemplateUri() {
    String csv = 'sep=,\n';
    csv += CSV_HEADER.join(',');
    String encoded = window.btoa(csv);
    return sanitizationService.bypassSecurityTrustUrl("data:text/csv;base64,${encoded}");
  }
}

@Pipe('projectOverviewFilter', pure: false)
class ProjectOverviewFilterPipe implements PipeTransform {
  List<Customer> transform(List<Entity> value, [List<Tag> selectedTags, bool showOnlySystemCustomers]) {
    if (value.isEmpty || value.first is! Customer) {
      return value;
    }

    Set<int> selectedTagIds = selectedTags.map((Tag t) => t.id as int).toSet();

    Iterable<Customer> resultIterator = (value as List<Customer>);

    if (showOnlySystemCustomers) {
      resultIterator = resultIterator.where((Customer c) => c.systemCustomer);
    }

    resultIterator = resultIterator.where((Customer c) {
      Set<int> customerTagIds = c.tags.map((Tag t) => t.id as int).toSet();
      return selectedTagIds.difference(customerTagIds).isEmpty;
    });

    return resultIterator.toList();
  }
}
