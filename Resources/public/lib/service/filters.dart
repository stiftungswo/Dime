library dime.filters;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';

@Formatter(name: 'userfilter')
class UserFilter {
  call(entityList, user) {
    if (entityList is Iterable && user is User) {
      return entityList.where((i) => i.user.username == user.username).toList();
    }
    return const [];
  }
}

@Formatter(name: 'timeslicedatefilter')
class TimesliceDateFilter{
  call(entityList, start, end){
    if(entityList is Iterable && (start is DateTime || end is DateTime)){
      if(start is DateTime && end == null){
        //Only Show Timeslices that begin after start
        return entityList.where((i) => i.startedAt.isAfter(start));
      } else if(end is DateTime && start == null){
        //Only Show Timeslices that end before end
        return entityList.where((i) => i.startedAt.isBefore(end));
      } else if(start is DateTime && end is DateTime){
        //Show Timeslices that startedAt between start and end
        return entityList.where((i) => (i.startedAt.isAfter(start) && i.startedAt.isBefore(end)));
      }
    }
    return const[];
  }
}

@Formatter(name: 'projectvaluefilter')
class ProjectValueFilter{
  call(projects, filterProjectId){
    if(projects is Iterable && filterProjectId is int){
      return projects.where((i)=>i.project.id == filterProjectId);
    }
    return const[];
  }
}

@Formatter(name: 'offerpostionOrder')
class OfferPositionOrderByOrderField {
  call(offerPositions){
    if(offerPositions is List<OfferPosition>){
      offerPositions.sort((x,y)=> x.order.compareTo(y.order));
      return offerPositions;
    }
  }
}