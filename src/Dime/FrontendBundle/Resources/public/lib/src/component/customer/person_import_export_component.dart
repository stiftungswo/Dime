import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../common/copy_input_component.dart';
import '../common/dime_directives.dart';
import '../common/download_button_component.dart';
import '../common/help_tooltip_component.dart';
import '../select/select.dart';
import 'customer_import_export_component.dart';

@Component(selector: 'person-import-export', templateUrl: 'person_import_export_component.html', directives: const [
  coreDirectives,
  formDirectives,
  dimeDirectives,
  DownloadButtonComponent,
  HelpTooltipComponent,
  TagSelectComponent,
  RateGroupSelectComponent,
  CopyInputComponent
])
class PersonImportExportComponent extends CustomerImportExportComponent<Person> {
  PersonImportExportComponent(DomSanitizationService sanitizationService, StatusService statusService, HttpService http, ObjectStore store)
      : super(sanitizationService, statusService, http, store);

  @override
  String importType = 'persons';

  @override
  Person buildFromRow(List<String> row) {
    Person entity = new Person()
      ..salutation = row[0]
      ..firstName = row[1]
      ..lastName = row[2]
      ..email = row[4]
      ..comment = row[12];

    // add address if street, postcode and city is filled out
    if (row[7].isNotEmpty && row[9].isNotEmpty && row[10].isNotEmpty) {
      entity.addresses.add(new Address()
        ..street = row[7]
        ..supplement = row[8]
        ..postcode = int.tryParse(row[9])
        ..city = row[10]
        ..country = row[11]);
    }

    // add company if not empty
    if (row[3].isNotEmpty) {
      entity.company = new Company()..name = row[3];
    }

    // add phone number if not empty
    if (row[5].isNotEmpty) {
      entity.phoneNumbers.add(new Phone()
        ..number = row[2]
        ..category = 3
        ..customer = entity);
    }

    // add mobile number if not empty
    if (row[6].isNotEmpty) {
      entity.phoneNumbers.add(new Phone()
        ..number = row[3]
        ..category = 4
        ..customer = entity);
    }

    return entity;
  }

  @override
  List<String> csvHeaders() => [
        'Anrede',
        'Vorname',
        'Nachname',
        'Firma',
        'E-Mail',
        'Telefonnummer',
        'Mobiltelefonnummer',
        'Strasse',
        'Adresszusatz',
        'Postleitzahl',
        'Stadt',
        'Land',
        'Kommentar'
      ];

  @override
  List<String> fieldsToUpdate() => [
        'salutation',
        'firstName',
        'lastName',
        'company',
        'phoneNumbers',
        'addresses',
        'hideForBusiness',
        'tags',
        'email',
        'comment',
        'rateGroup',
        'chargeable'
      ];

  @override
  findDuplicates() async {
    await statusService.run(() async {
      var list = customersToImport;
      var persons = list.map((p) {
        Person pe = p.item;
        return {'firstName': pe.firstName, 'lastName': pe.lastName, 'company': pe.company?.name, 'email': pe.email};
      }).toList();

      String body = json.encode({'persons': persons});
      String response = await http.post('persons/import/check', body: body);
      List<bool> result = List<bool>.from(json.decode(response) as List);

      int i = 0;
      result.forEach((entry) {
        list[i++].isDuplicate = entry;
      });
    });

    importCheckedForDuplicates = true;
  }
}
