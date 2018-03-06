class Menu {
  String title;
  String icon;
  List<Menu> items = const [];
  List<String> link;
  Menu.child(this.title, this.link);
  Menu.withItems(this.title, this.icon, this.items);
  Menu.single(this.title, this.icon, this.link);
}
