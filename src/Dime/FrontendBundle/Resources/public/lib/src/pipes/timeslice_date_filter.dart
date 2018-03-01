import 'package:angular/core.dart';
import '../model/Entity.dart';

//TODO since this is a component specific filter, move it to timeslice_overview.dart
@Pipe('timeslicedatefilter', pure: false)
class TimesliceDateFilterPipe implements PipeTransform {
  transform(List<Entity> values, DateTime start, DateTime end) {
    return values; //TODO: implement
//    search = search.toLowerCase();
//    Iterable<Entity> filteredValues = values.where((Entity e) {
//      return searchProperties.any((property) => e.Get(property).toString().toLowerCase().contains(search));
//    });
//
//    return filteredValues.toList();
  }
}
