library dime.filters;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';

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
    if (filterProjectId == null) {
      return items;
    } else if (filterProjectId is !int) {
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