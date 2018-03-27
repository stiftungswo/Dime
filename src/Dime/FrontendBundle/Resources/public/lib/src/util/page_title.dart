import 'dart:html';

void setPageTitle(String pageName, [String subPageName = null]) {
  String title = '${pageName} - DimeERP';
  if (subPageName != null && subPageName.isNotEmpty) {
    title = '${subPageName} - ${title}';
  }

  document.title = title;
}
