import 'package:angular/angular.dart';

@Component(
    selector: 'dime-button',
    template: """
    <span data-toggle="tooltip" title="{{tooltip}}" >
      <button type="button" class="{{getClass()}}" ng-disabled="!enabled">
          <span ng-if="glyphicon != null" class="glyphicon glyphicon-{{glyphicon}}"></span>
          <content></content>
      </button>
    </span>
    """,
    useShadowDom: false,
    map: const {
      "glyphicon": "@glyphicon",
      "tooltipText": "@tooltip",
      "primary": "@primary",
      "enabled": "=>enabled",
    })
class DimeButton {
  String glyphicon = null;
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
