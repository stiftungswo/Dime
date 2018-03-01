import 'package:DimeClient/src/pipes/filter.dart';
import 'package:DimeClient/src/pipes/limit_to.dart';
import 'package:DimeClient/src/pipes/order_by.dart';
import 'package:DimeClient/src/pipes/seconds_to_hours.dart';
import 'package:DimeClient/src/pipes/timeslice_date_filter.dart';

const DIME_PIPES = const [FilterPipe, LimitToPipe, OrderByPipe, SecondsToHoursPipe, TimesliceDateFilterPipe];
