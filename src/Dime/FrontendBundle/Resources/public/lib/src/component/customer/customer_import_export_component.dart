import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';

import '../../model/entity_export.dart';
import '../../pipe/filter_pipe.dart';
import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../common/copy_input_component.dart';
import '../common/dime_directives.dart';
import '../overview/root/customer_overview_component.dart';
import 'package:hammock/hammock.dart';

@Component(
  selector: 'customer-import-export',
  templateUrl: 'customer_import_export_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, CopyInputComponent],
)
class CustomerImportExportComponent {
  @Input()
  List<Customer> entities = [];
  @Input()
  String filterString = '';
  @Input()
  List<Tag> filterTags = [];
  @Input()
  bool showOnlySystemCustomer = false;

  final StreamController<List<Customer>> _import = new StreamController<List<Customer>>();
  @Output('import')
  Stream<List<Customer>> get import => _import.stream;

  HttpService http;
  ObjectStore store;
  StatusService statusservice;
  DomSanitizationService sanitizationService;

  List<Customer> customersToImport = [];

  CustomerImportExportComponent(this.http, this.sanitizationService, this.statusservice, this.store);

  String getEmailString() {
    var filterPipe = new FilterPipe();
    var projectFilterPipe = new ProjectOverviewFilterPipe();
    var tmpList = filterPipe.transform(this.entities, ['id', 'name', 'address'], filterString);
    return projectFilterPipe
        .transform(tmpList, filterTags, showOnlySystemCustomer)
        .where((Customer c) => c.email?.isNotEmpty ?? false)
        .map((Customer c) => "${c.name}<${c.email}>")
        .join(',');
  }

  String getCsvExportLink() {
    var params = {
      "search": filterString,
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

  doImport() async {
    await statusservice.run(() async {
      var customers = customersToImport.map((Customer c) {
        c
          ..systemCustomer = showOnlySystemCustomer
          ..tags = filterTags
          ..addFieldstoUpdate([
            'name',
            'company',
            'department',
            'salutation',
            'email',
            'phone',
            'fullname',
            'address',
            'tags',
            'systemCustomer',
          ]);
        return c.toMap();
      }).toList();
      var object = {"customers": customers};
      print(object);
      String body = new JsonEncoder().convert(object);

      List<Customer> result = await this.store.customQueryList<Customer>(
          Customer, new CustomRequestParams(method: 'post', url: '${http.baseUrl}/customers/import', data: body));
      _import.add(result);
    });
  }
}
