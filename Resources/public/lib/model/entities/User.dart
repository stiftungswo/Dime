part of dime_entity;

class User extends Entity {
  User();

  User.clone(User original): super.clone(original){
    this.username = 'cloneduser';
    this.firstname = original.firstname;
    this.lastname = original.lastname;
    this.email = 'cloned@example.com';
    this.enabled = original.enabled;
    this.locked = original.locked;
  }

  User.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new User();
  }

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('enabled')) {
      params['enabled'] = false;
    }
    if (!params.containsKey('locked')) {
      params['locked'] = true;
    }
    super.init(params: params);
  }

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
        case 'email':
          return this.email;
        case 'enabled':
          return this.enabled;
        case 'locked':
          return this.locked;
        case 'plainpassword':
          return this.plainpassword;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'username':
        this.username = value;
        break;
      case 'firstname':
        this.firstname = value;
        break;
      case 'lastname':
        this.lastname = value;
        break;
      case 'email':
        this.email = value;
        break;
      case 'enabled':
        this.enabled = value;
        break;
      case 'locked':
        this.locked = value;
        break;
      case 'plainpassword':
        this.plainpassword = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'users';
  String username;
  String firstname;
  String lastname;
  String email;
  String plainpassword;
  bool enabled;
  bool locked;

  String get fullname {
    return '$firstname $lastname';
  }

}