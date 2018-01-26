import 'package:angular/angular.dart';

@Component(
    selector: 'dime-button',
    template: """
    <span data-toggle="tooltip" title="{{tooltip}}" >
      <button type="button" class="{{getClass()}}" ng-disabled="!enabled" ng-click='onClick()'>
          <span ng-if="glyphicon != null" class="glyphicon glyphicon-{{glyphicon}}"></span>
          <span ng-if="fontAwesome != null" class="fa fa-{{fontAwesome}}"></span>
          <content></content>
      </button>
    </span>
    """,
    useShadowDom: false,
    map: const {
      "glyphicon": "@glyphicon",
      "font-awesome": "@fontAwesome",
      "tooltipText": "@tooltip",
      "primary": "@primary",
      "enabled": "=>enabled",
      "click": "&onClick",
    })
class DimeButton {
  Function onClick = () {};
  String glyphicon = null;
  String fontAwesome = null;
  String tooltip = null;
  String primary = null;
  bool enabled = true;

  getClass() {
    if (primary == null) {
      return "btn btn-default";
    } else {
      return "btn btn-primary";
    }
  }
}
