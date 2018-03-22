import 'package:hammock/hammock.dart';
import 'package:meta/meta.dart';

import 'entities/Tag.dart';
import 'entities/User.dart';

class Entity {
  Entity();

  Entity.clone(Entity original) {
    this.name = original.name;
    this.user = original.user;
    addFieldstoUpdate(['name', 'user']);
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

  Entity.fromMap(Map<String, dynamic> map) {
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
          if (value.id != null) {
            value.addFieldtoUpdate('id');
          } else {
            // set to null if id is null or not present (empty object / not loaded)
            value = null;
          }
        }
        if (value != null) {
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

  cloneDescendants(Entity original) {}

  @protected
  List<Entity> descendantsToUpdate_ = [];

  List<Entity> get descendantsToUpdate => descendantsToUpdate_;

  dynamic id;
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

  @protected
  DateTime addDateValue(dynamic value) {
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
    if (this._toUpdate.isNotEmpty) {
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

  void Set(String property, dynamic value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'createdAt':
        this.createdAt = addDateValue(value);
        break;
      case 'updatedAt':
        this.updatedAt = addDateValue(value);
        break;
      case 'name':
        this.name = value as String;
        break;
      case 'alias':
        this.alias = value as String;
        break;
      case 'user':
        this.user = value is User ? value : new User.fromMap(value as Map<String, dynamic>);
        break;
      case 'tags':
        this.tags = Tag.listFromMap(value as List<Map<String, dynamic>>);
        break;
      default:
        //print('Trying to set ${property} with ${value} in ${this.type} but it does not exist or has no setter');
        break;
    }
  }
}
