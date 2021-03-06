import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';

@Component(
  selector: 'revenue-report',
  templateUrl: 'revenue_report_component.html',
  directives: const [coreDirectives, dimeDirectives],
)
class RevenueReportComponent implements OnActivate {
  RevenueReportComponent(StatusService this.statusservice, this.http);

  HttpService http;

  DateTime filterStartDate;

  DateTime filterEndDate;

  StatusService statusservice;

  @override
  onActivate(_, __) {
    DateTime now = new DateTime.now();
    this.filterStartDate = new DateTime(now.year, 1, 1);
    this.filterEndDate = new DateTime(now.year, 12, 31);
    page_title.setPageTitle('Umsatzstatistik');
  }

  String getCsvLink() {
    if (filterStartDate != null && filterEndDate != null) {
      return '${http.baseUrl}/reports/revenue/csv?date=${encodeDateRange(filterStartDate, filterEndDate)}';
    } else {
      return '';
    }
  }
}
