import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math' as math;

import 'package:angular/angular.dart';
import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../pipe/filter_pipe.dart';
import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../common/copy_input_component.dart';
import '../common/dime_directives.dart';
import '../overview/root/customer_overview_component.dart';
import '../select/rate_group_select_component.dart';
import '../select/tag_select_component.dart';

@Component(
  selector: 'customer-import-export',
  templateUrl: 'customer_import_export_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, CopyInputComponent, RateGroupSelectComponent, TagSelectComponent],
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

  List<PreviewItem> customersToImport = [];
  bool importIsSystemkune = false;
  List<Tag> importTags = [];
  RateGroup importRateGroup = null;

  int importProgress = 0;
  int get importTotal => customersToImport.length;

  CustomerImportExportComponent(this.http, this.sanitizationService, this.statusservice, this.store);

  String getEmailString() {
    var filterPipe = new FilterPipe();
    var projectFilterPipe = new ProjectOverviewFilterPipe();
    List<Entity> tmpList = filterPipe.transform(this.entities, ['id', 'name', 'address'], filterString);
    return projectFilterPipe
        .transform(tmpList, filterTags, showOnlySystemCustomer)
        .where((Customer c) => c.email?.isNotEmpty ?? false)
        .map((Customer c) => "${c.name}<${c.email}>")
        .join(',');
  }

  String getCsvExportLink() {
    var params = {
      "search": filterString,
      "withTags": filterTags.map((Tag t) => t.id.toString()).join(","),
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

    List<Customer> customers = parseCsv(fileContent);

    customersToImport = customers.map((Customer c) => new PreviewItem(c)).toList();
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

      completer.complete(eventTarget.result as String);
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
    'Mobiltelefonnummer',
    'Kommentar',
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
    List<List<String>> rows = converter.convert(input) as List<List<String>>;

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

    return rows.map((List<String> row) {
      Customer customer = new Customer()
            ..name = row[0]
            ..company = row[1]
            ..department = row[2]
            ..salutation = row[3]
            ..email = row[4]
            ..phone = row[5]
            ..mobilephone = row[6]
            ..comment = row[7]
            ..fullname = row[8]
          //..chargeable = /*get from form*/
          //..systemCustomer = /*get from form*/
          ;
      customer.address = new Address()
        ..street = row[9]
        ..supplement = row[10]
        ..plz = int.parse(row[11], onError: (source) => null)
        ..city = row[12]
        ..country = row[13];
      return customer;
    }).toList();
  }

  SafeUrl getCsvTemplateUri() {
    String csv = 'sep=,\n';
    csv += CSV_HEADER.join(',');
    String encoded = window.btoa(csv);
    return sanitizationService.bypassSecurityTrustUrl("data:text/csv;base64,${encoded}");
  }

  findDuplicates() async {
    await statusservice.run(() async {
      var list = customersToImport;
      var customers = list.map((PreviewItem p) {
        Customer c = p.item;
        return {
          'name': c.name,
          'company': c.company,
          'email': c.email,
          'fullname': c.fullname,
        };
      }).toList();

      String body = JSON.encode({"customers": customers});

      String response = await http.post('customers/import/check', body: body);
      var result = JSON.decode(response) as List<List<Map<String, dynamic>>>;
      int i = 0;
      result.forEach((List<Map<String, dynamic>> row) =>
          list[i++].duplicates = row.map((Map<String, dynamic> item) => new Customer.fromMap(item)).toList());
    });
  }

  doImport() async {
    if (importRateGroup == null) {
      window.alert('Keine Tarif Gruppe ausgewählt');
      return;
    }
    importProgress = 0;
    List<Map<String, dynamic>> customers = customersToImport.map((PreviewItem p) {
      Customer c = p.item;
      c
        ..systemCustomer = importIsSystemkune
        ..tags = importTags
        ..rateGroup = importRateGroup
        ..addFieldstoUpdate([
          'name',
          'company',
          'department',
          'salutation',
          'email',
          'phone',
          'mobilephone',
          'comment',
          'fullname',
          'address',
          'tags',
          'systemCustomer',
          'rateGroup',
        ]);
      return c.toMap();
    }).toList();
    await statusservice.run(() async {
      List<Customer> result = [];

      for (Iterable<Map<String, dynamic>> chunk in chunk(customers, 25)) {
        var object = {"customers": chunk.toList(growable: false)};

        String body = new JsonEncoder().convert(object);

        result.addAll(await this.store.customQueryList<Customer>(
            Customer, new CustomRequestParams(method: 'post', url: '${http.baseUrl}/customers/import', data: body)));
        importProgress += chunk.length;
      }

      _import.add(result);
    });
  }

  Iterable<Iterable<T>> chunk<T>(List<T> list, int chunkSize) sync* {
    int chunks = (list.length / chunkSize).ceil() - 1;
    for (int i = 0; i <= chunks; i++) {
      yield list.getRange(i * chunkSize, math.min(i * chunkSize + chunkSize, list.length));
    }
  }

  remove(PreviewItem item) => customersToImport.remove(item);
}

class PreviewItem {
  Customer item;
  List<Customer> duplicates;

  bool get isDuplicate => duplicates.isNotEmpty;

  PreviewItem(this.item, [this.duplicates = const []]);
}
