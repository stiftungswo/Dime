import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

import '../../service/http_service.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';

@Component(selector: 'revenue-report', templateUrl: 'revenue_report.html', directives: const [CORE_DIRECTIVES, dimeDirectives])
class RevenueReportComponent implements OnInit {
  RevenueReportComponent(StatusService this.statusservice, this.http);

  HttpService http;

  DateTime filterStartDate;

  DateTime filterEndDate;

  StatusService statusservice;

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
      // TODO: this code seems dead - remove it
      String _ = '&date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
    }
  }

  getCsvLink() {
    if (filterStartDate != null && filterEndDate != null) {
      return '${http.baseUrl}/reports/revenue/csv?date=${encodeDateRange(filterStartDate, filterEndDate)}';
    } else {
      return '';
    }
  }
}
