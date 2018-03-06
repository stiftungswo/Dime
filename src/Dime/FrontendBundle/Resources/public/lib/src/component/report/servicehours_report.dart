import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';

import '../../component/elements/dime_directives.dart';
import '../../service/http_service.dart';
import '../../service/status.dart';

@Component(
    selector: 'servicehours-report',
    templateUrl: 'servicehours_report.html',
    directives: const [CORE_DIRECTIVES, dimeDirectives],
    pipes: const [COMMON_PIPES])
class ServicehoursReportComponent implements OnInit {
  ServicehoursReportComponent(StatusService this.statusservice, this.http);

  DateTime filterStartDate;

  DateTime filterEndDate;

  List<dynamic> entries;

  Map<String, dynamic> total;

  Type type;

  StatusService statusservice;

  HttpService http;

  @override
  ngOnInit() {
    DateTime now = new DateTime.now();
    this.filterStartDate = new DateTime(now.year, 1, 1);
    this.filterEndDate = new DateTime(now.year, 12, 31);
    reload();
  }

  void reloadEvict() => reload(evict: true);

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (filterStartDate != null && filterEndDate != null) {
      String dateparams = encodeDateRange(filterStartDate, filterEndDate);
      this.entries = null;
      this.total = null;
      this.statusservice.setStatusToLoading();
      try {
        await http.get('reports/servicehours', queryParams: {"_format": 'json', "date": dateparams}).then((result) {
          var data = JSON.decode(result);
          window.console.log(data);
          this.entries = data['projects'];
          this.total = data['total'];
        });
        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  num getTime(dynamic map, String key) {
    if (map is List) {
      return null;
    } else {
      final time = map[key];
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
