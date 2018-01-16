library dime_entity;

import 'package:hammock/hammock.dart';
import 'dart:html';
import 'dart:math';

part 'entities/Activity.dart';
part 'entities/Address.dart';
part 'entities/Customer.dart';
part 'entities/Employee.dart';
part 'entities/ExpenseReport.dart';
part 'entities/Holiday.dart';
part 'entities/Costgroup.dart';
part 'entities/Invoice.dart';
part 'entities/InvoiceBreakdown.dart';
part 'entities/InvoiceCostgroup.dart';
part 'entities/InvoiceDiscount.dart';
part 'entities/InvoiceItem.dart';
part 'entities/Offer.dart';
part 'entities/OfferDiscount.dart';
part 'entities/OfferPosition.dart';
part 'entities/OfferStatusUC.dart';
part 'entities/Period.dart';
part 'entities/Phone.dart';
part 'entities/Project.dart';
part 'entities/Rate.dart';
part 'entities/RateGroup.dart';
part 'entities/RateUnitType.dart';
part 'entities/Service.dart';
part 'entities/Setting.dart';
part 'entities/StandardDiscount.dart';
part 'entities/Tag.dart';
part 'entities/Timeslice.dart';
part 'entities/User.dart';
part 'entities/ProjectCategory.dart';
part 'entities/ProjectComment.dart';
part 'entities/SettingAssignProject.dart';

class Entity {

  Entity();

  Entity.clone(Entity original){
    this.name = original.name;
    this.user = original.user;
    addFieldstoUpdate(['name','user']);
  }

  init({Map<String, dynamic> params: const {}}) {
    if (params != null) {
      for (var key in params.keys) {
        var value = params[key];
        this.Set(key, value);
        this.addFieldtoUpdate(key);
      }
    }
  }

  Entity.fromMap(Map<String, dynamic> map){
    if (map == null || map.isEmpty) return;
    for (String key in map.keys) {
      var value = map[key];
      this.Set(key, value);
    }
  }

  Resource toResource() {
    return new Resource(type, this.id, this.toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    for (String item in this._toUpdate) {
      var value = this.Get(item);
      if (value == null) {
        //print('Trying to get ${item} from ${this.type} but it does not exist or has no getter');
      } else if (value is Entity) {
        //TODO Fix Handling of Subentities in Backend. I Probably neeed a form transformer
        if (value.type == 'address') {
          value.addFieldtoUpdate('street');
          value.addFieldtoUpdate('streetnumber');
          value.addFieldtoUpdate('city');
          value.addFieldtoUpdate('plz');
          value.addFieldtoUpdate('state');
          value.addFieldtoUpdate('country');
        } else {
          // FIXME: this is kind of a hack to fix cloning, could possibly set fields to null in some cases
          if(value.id != null){
            value.addFieldtoUpdate('id');
          } else {
            // set to null if id is null or not present (empty object / not loaded)
            value = null;
          }
        }
        if (value != null){
          value = value.toMap();
        }
      } else if (value is DateTime) {
        value = value.toString();
      }
      map[item] = value;
    }
    this._toUpdate = [];
    return map;
  }

  cloneDescendants(Entity original) {

  }

  List _descendantsToUpdate = [];

  List get descendantsToUpdate => _descendantsToUpdate;

  var id;
  List<String> _toUpdate = [];
  String type = 'entities';

  DateTime createdAt;
  DateTime updatedAt;

  String name;
  String alias;
  User user;
  List<Tag> tags = [];

  void addFieldtoUpdate(String name) {
    if (!this._toUpdate.contains(name)) {
      this._toUpdate.add(name);
    }
  }

  void addFieldstoUpdate(List<String> names) {
    for (String name in names) {
      this.addFieldtoUpdate(name);
    }
  }

  DateTime _addDateValue(value) {
    if (value == null) {
      return null;
    }
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      return DateTime.parse(value);
    } else {
      return null;
    }
  }

  bool get needsUpdate {
    if (this._toUpdate.length >= 1) {
      return true;
    }
    return false;
  }

  dynamic newObj() {
    return new Entity();
  }

  dynamic Get(String property) {
    switch (property) {
      case 'id':
        return this.id;
      case 'name':
        return this.name;
      case 'alias':
        return this.alias;
      case 'createdAt':
        return this.createdAt;
      case 'updatedAt':
        return this.updatedAt;
      case 'user':
        return this.user;
      case 'tags':
        return this.tags;
      default:
        break;
    }
    return null;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'createdAt':
        this.createdAt = _addDateValue(value);
        break;
      case 'updatedAt':
        this.updatedAt = _addDateValue(value);
        break;
      case 'name':
        this.name = value;
        break;
      case 'alias':
        this.alias = value;
        break;
      case 'user':
        this.user = value is Entity ? value : new Employee.fromMap(value);
        break;
      case 'tags':
        this.tags = Tag.listFromMap(value);
        break;
      default:
        //print('Trying to set ${property} with ${value} in ${this.type} but it does not exist or has no setter');
        break;
    }
  }
}
