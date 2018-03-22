import '../entity_export.dart';
import 'dart:math';

class User extends Entity {
  static const ROLE_ADMIN = 'ROLE_SUPER_ADMIN';

  User();

  User.clone(User original) : super.clone(original) {
    String random = new Random().nextInt(1000).toString();
    this.username = original.username + '_cloned' + random;
    this.firstname = original.firstname;
    this.lastname = original.lastname;
    this.email = 'cloned' + random + '_' + original.email;
    this.enabled = original.enabled;
    this.employeeholiday = original.employeeholiday;
    this.roles = []; // dont carry over roles by default
    addFieldstoUpdate(['username', 'firstname', 'lastname', 'email', 'enabled', 'employeeholiday']);
  }

  User.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  User newObj() {
    return new User();
  }

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('enabled')) {
      params['enabled'] = false;
    }
    super.init(params: params);
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'username':
          return this.username;
        case 'firstname':
          return this.firstname;
        case 'lastname':
          return this.lastname;
        case 'fullname':
          return this.fullname; // useful for our filter / orderBy pipes
        case 'email':
          return this.email;
        case 'enabled':
          return this.enabled;
        case 'plainpassword':
          return this.plainpassword;
        case 'employeeholiday':
          return this.employeeholiday;
        case 'roles':
          return this.roles;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'username':
        this.username = value as String;
        break;
      case 'firstname':
        this.firstname = value as String;
        break;
      case 'lastname':
        this.lastname = value as String;
        break;
      case 'email':
        this.email = value as String;
        break;
      case 'enabled':
        this.enabled = value as bool;
        break;
      case 'plainpassword':
        this.plainpassword = value as String;
        break;
      case 'employeeholiday':
        this.employeeholiday = value as int;
        break;
      case 'roles':
        this.roles = value as List<String>;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'users';
  String username;
  String firstname;
  String lastname;
  String email;
  String plainpassword;
  bool enabled;
  int employeeholiday;
  List<String> roles = [];

  String get fullname {
    return '$firstname $lastname';
  }

  bool isAdmin() => roles.contains(User.ROLE_ADMIN);
}
