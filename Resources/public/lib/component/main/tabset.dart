library main_tabset;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/viewlink.dart';

@Component(
    selector: 'maintabset',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/main/tabset.html',
    useShadowDom: false)
class TabSetComponent implements ScopeAware {

  Scope scope;
  List<ViewLink> linklist = new List<ViewLink>();

  addLink(String title, String url) {
    linklist.add(new ViewLink()
      ..url = url
      ..Title = title);
  }

  removeLink(int index) {
    linklist.removeAt(index);
  }

}