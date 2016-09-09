library dime.filters;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'dart:html';

@Formatter(name: 'userfilter')
class UserFilter {
  call(List entityList, user) {
    if (user is User && entityList != null) {
      return entityList.where((i) => i.user.username == user.username).toList();
    }
    return const [];
  }
}

@Formatter(name: 'timeslicedatefilter')
class TimesliceDateFilter {
  call(List entityList, start, end) {
    if ((start is DateTime || end is DateTime) && entityList != null) {
      if (end != null){
        // set end date to end of day to include entries of the last day
        end = end.add(new Duration(hours: 23, minutes: 59));
      }
      if (start is DateTime && end == null) {
        //Only Show Timeslices that begin after start
        return entityList.where((i) => i.startedAt.isAfter(start));
      } else if (end is DateTime && start == null) {
        //Only Show Timeslices that end before end
        return entityList.where((i) => i.startedAt.isBefore(end));
      } else if (start is DateTime && end is DateTime) {
        //Show Timeslices that startedAt between start and end
        return entityList.where((i) => (i.startedAt.isAfter(start) && i.startedAt.isBefore(end)));
      }
    }
    return const[];
  }
}

@Formatter(name: 'projectvaluefilter')
class ProjectValueFilter {
  List call(List items, filterProjectId) {
    if (items == null || filterProjectId == null || filterProjectId is !int) {
      return const [];
    }
    return items.where((i) => i.project.id == filterProjectId);
  }
}

@Formatter(name: 'offerpostionOrder')
class OfferPositionOrderByOrderField {
  List call(List<OfferPosition> offerPositions) {
    offerPositions.sort((x, y) => x.order.compareTo(y.order));
    return offerPositions;
  }
}

@Formatter(name: 'invoiceitemOrder')
class InvoiceItemOrderByOrderField {
  List call(List<InvoiceItem> items) {
    items.sort((x, y){
      if (x.order != null && y.order != null) {
        return x.order.compareTo(y.order);
      }
      return 0;
    });
    return items;
  }
}

@Formatter(name: 'secondsToHours')
class SecondsToHours {
  String call(int seconds) {
    if (seconds != null) {
      return (seconds / 3600).toStringAsFixed(1).toString() + 'h';
    } else {
      return null;
    }
  }
}