import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';

@Component(
    selector: 'service-hours-report',
    templateUrl: 'service_hours_report_component.html',
    directives: const [coreDirectives, dimeDirectives],
    pipes: const [commonPipes])
class ServiceHoursReportComponent implements OnActivate {
  ServiceHoursReportComponent(StatusService this.statusservice, this.http);

  DateTime filterStartDate;

  DateTime filterEndDate;

  List<dynamic> entries;

  Map<String, dynamic> total;

  Type type;

  StatusService statusservice;

  HttpService http;

  @override
  onActivate(_, __) {
    DateTime now = new DateTime.now();
    this.filterStartDate = new DateTime(now.year, 1, 1);
    this.filterEndDate = new DateTime(now.year, 12, 31);
    reload();
    page_title.setPageTitle('Servicerapport');
  }

  void reloadEvict() => reload(evict: true);

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (filterStartDate != null && filterEndDate != null) {
      String dateparams = encodeDateRange(filterStartDate, filterEndDate);
      this.entries = null;
      this.total = null;
      await this.statusservice.run(() async {
        await http.get('reports/servicehours', queryParams: {"_format": 'json', "date": dateparams}).then((result) {
          dynamic data = json.decode(result);
          window.console.log(data);
          this.entries = data['projects'] as List<dynamic>;
          this.total = data['total'] as Map<String, dynamic>;
        });
      });
    }
  }

  num getTime(dynamic map, String key) {
    if (map is List) {
      return null;
    } else {
      final time = map[key] as num;
      return time != null ? time / 3600 : null;
    }
  }

  getCsvLink() {
    if (filterStartDate != null && filterEndDate != null) {
      return '${http.baseUrl}/reports/servicehours/csv?date=${encodeDateRange(filterStartDate, filterEndDate)}';
    } else {
      return '';
    }
  }
}
