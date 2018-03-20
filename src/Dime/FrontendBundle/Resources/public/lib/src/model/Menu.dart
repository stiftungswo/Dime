class Menu {
  String title;
  String icon;
  List<Menu> items = const [];
  List<String> link;
  bool adminOnly;
  Menu.child(this.title, this.link, {this.adminOnly = false});
  Menu.withItems(this.title, this.icon, this.items, {this.adminOnly = false});
  Menu.single(this.title, this.icon, this.link, {this.adminOnly = false});
}
