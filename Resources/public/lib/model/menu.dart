library menu;

class Menu {
  String title;
  List<Menu> items;
  bool isOpen = true;
  String link;
  Menu(this.title, this.link);
  Menu.withItems(this.title, this.items);
}