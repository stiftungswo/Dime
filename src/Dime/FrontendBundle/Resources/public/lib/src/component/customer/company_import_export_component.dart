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

@Component(selector: 'company-import-export', templateUrl: 'company_import_export_component.html', directives: const [
  coreDirectives,
  formDirectives,
  dimeDirectives,
  DownloadButtonComponent,
  HelpTooltipComponent,
  TagSelectComponent,
  RateGroupSelectComponent,
  CopyInputComponent
])
class CompanyImportExportComponent extends CustomerImportExportComponent<Company> {
  CompanyImportExportComponent(DomSanitizationService sanitizationService, StatusService statusService, HttpService http, ObjectStore store)
      : super(sanitizationService, statusService, http, store);

  @override
  String importType = 'companies';

  @override
  Company buildFromRow(List<String> row) {
    Company entity = new Company()
      ..name = row[0]
      ..email = row[1]
      ..comment = row[9];

    // add address if street, postcode and city is filled out
    if (row[4].isNotEmpty && row[6].isNotEmpty && row[7].isNotEmpty) {
      entity.addresses.add(new Address()
        ..street = row[4]
        ..supplement = row[5]
        ..postcode = int.tryParse(row[6])
        ..city = row[7]
        ..country = row[8]);
    }

    // add phone number if not empty
    if (row[2].isNotEmpty) {
      entity.phoneNumbers.add(new Phone()
        ..number = row[2]
        ..category = 1
        ..customer = entity);
    }

    // add mobile number if not empty
    if (row[3].isNotEmpty) {
      entity.phoneNumbers.add(new Phone()
        ..number = row[3]
        ..category = 4
        ..customer = entity);
    }

    return entity;
  }

  @override
  List<String> csvHeaders() =>
      ['Firma', 'E-Mail', 'Telefonnummer', 'Mobiltelefonnummer', 'Strasse', 'Adresszusatz', 'Postleitzahl', 'Stadt', 'Land', 'Kommentar'];

  @override
  List<String> fieldsToUpdate() =>
      ['name', 'phoneNumbers', 'addresses', 'hideForBusiness', 'tags', 'email', 'comment', 'rateGroup', 'chargeable'];

  @override
  findDuplicates() async {
    await statusService.run(() async {
      var list = customersToImport;
      var companies = list.map((p) {
        Company c = p.item;
        return {'name': c.name, 'email': c.email};
      }).toList();

      String body = json.encode({"companies": companies});
      String response = await http.post('companies/import/check', body: body);
      List<bool> result = List<bool>.from(json.decode(response) as List);

      int i = 0;
      result.forEach((entry) {
        list[i++].isDuplicate = entry;
      });
    });

    importCheckedForDuplicates = true;
  }
}
