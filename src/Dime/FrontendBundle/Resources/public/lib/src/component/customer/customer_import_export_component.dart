import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math' as math;

import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import '../../service/http_service.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../service/status_service.dart';

abstract class CustomerImportExportComponent<T extends Customer> {
  DomSanitizationService sanitizationService;
  HttpService http;
  ObjectStore store;
  StatusService statusService;

  List<PreviewItem<T>> customersToImport = [];
  bool importChargeable = true;
  bool importCheckedForDuplicates = false;
  bool importIsHiddenForBusiness = false;
  int importProgress = 0;
  RateGroup importRateGroup = null;
  bool importRunning = false;
  List<Tag> importTags = [];
  int get importTotal => customersToImport.length;
  String importType = 'customers';

  CustomerImportExportComponent(this.sanitizationService, this.statusService, this.http, this.store);

  Iterable<Iterable<T>> chunk<T>(List<T> list, int chunkSize) sync* {
    int chunks = (list.length / chunkSize).ceil() - 1;
    for (int i = 0; i <= chunks; i++) {
      yield list.getRange(i * chunkSize, math.min(i * chunkSize + chunkSize, list.length));
    }
  }

  doImport() async {
    if (importRateGroup == null) {
      window.alert('Keine Tarif-Gruppe ausgewählt!');
      return;
    }

    if (!importCheckedForDuplicates && !window.confirm('Achtung: Der Import wurde nicht auf Duplikate geprüft. Fortfahren?')) {
      return;
    }

    importRunning = true;
    importProgress = 0;
    List<Map<String, dynamic>> customers = customersToImport.map((p) {
      T c = p.item;

      c
        ..hideForBusiness = importIsHiddenForBusiness
        ..tags = importTags
        ..rateGroup = importRateGroup
        ..chargeable = importChargeable
        ..addFieldstoUpdate(fieldsToUpdate());
      return c.toMap();
    }).toList();

    await this.statusService.run(() async {
      List<T> result = [];

      for (Iterable<Map<String, dynamic>> chunk in chunk(customers, 25)) {
        var object = {importType: chunk.toList(growable: false)};

        String body = json.encode(object);

        result.addAll(await this
            .store
            .customQueryList<T>(T, new CustomRequestParams(method: 'post', url: '${http.baseUrl}/${importType}/import', data: body)));

        importProgress += chunk.length;
      }
    });

    // wait a few seconds, so progress bar has a chance to update
    // https://www.programming-idioms.org/idiom/45/pause-execution-for-5-seconds/616/dart
    await new Future.delayed(const Duration(seconds: 3));
    if (window.confirm('Import erfolgreich beendet! Bitte "OK" klicken, um die Seite neu zu laden.')) {
      window.location.reload();
    }
  }

  importFile(FileList files) async {
    if (files.length != 1) {
      window.alert('Es muss genaue eine Datei ausgewählt werden!');
      return;
    }

    importCheckedForDuplicates = false;
    File file = files.single;
    String fileContent = await readFileToString(file);
    List<T> customers = parseCsv(fileContent);
    customersToImport = customers.map((c) => new PreviewItem(c)).toList().cast<PreviewItem<T>>();
  }

  SafeUrl getCsvTemplateUri() {
    String csv = 'sep=,\n';
    csv += csvHeaders().join(',');
    String encoded = window.btoa(csv);
    return sanitizationService.bypassSecurityTrustUrl("data:text/csv;base64,${encoded}");
  }

  double get importProgressPercentage => importProgress / importTotal * 100;

  String getMainPhoneNumber(Customer entity) {
    List<Phone> list = entity.phoneNumbers.where((p) => p.category == 1 || p.category == 3).toList();

    if (list.isEmpty) {
      return '';
    } else {
      return list.first.number;
    }
  }

  String getMobilePhoneNumber(Customer entity) {
    List<Phone> list = entity.phoneNumbers.where((p) => p.category == 4).toList();

    if (list.isEmpty) {
      return '';
    } else {
      return list.first.number;
    }
  }

  List<T> parseCsv(String input) {
    const d = const FirstOccurrenceSettingsDetector(
      eols: const ['\r\n', '\n', '\r'],
      textDelimiters: const ['"', "'"],
      fieldDelimiters: const [',', ';'],
    );

    const converter = const CsvToListConverter(shouldParseNumbers: false, csvSettingsDetector: d, allowInvalid: true);

    List<List<String>> rows = converter.convert(input).map((sublist) => sublist.cast<String>()).toList();

    if (rows.isNotEmpty && rows.first.isNotEmpty && rows.first.first == 'sep=') {
      // skip excel separator mark
      rows = rows.sublist(1);
    }
    if (rows.isNotEmpty && rows.first.join() == csvHeaders().join()) {
      // skip csv header
      rows = rows.sublist(1);
    }

    if (rows.isEmpty || rows.first.length != csvHeaders().length) {
      window.alert("Die ausgewählte Datei scheint leer oder nicht korrekt formatiert zu sein!");
      return [];
    }

    return rows.map((row) => buildFromRow(row)).toList();
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

  remove(PreviewItem<T> item) => customersToImport.remove(item);

  removeAllDuplicates() {
    customersToImport = customersToImport.where((p) => !p.isDuplicate).toList();
  }

  T buildFromRow(List<String> row);
  List<String> csvHeaders();
  findDuplicates();
  List<String> fieldsToUpdate();
}

class PreviewItem<T extends Entity> {
  T item;
  bool isDuplicate = false;

  PreviewItem(this.item);
}
