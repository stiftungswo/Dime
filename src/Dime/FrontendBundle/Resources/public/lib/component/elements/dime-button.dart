import 'package:angular/angular.dart';

@Component(
    selector: 'dime-button',
    template: """
    <button type="button" class="{{getClass()}}" data-toggle="tooltip" title="{{tooltip}}" ng-disabled="!enabled">
        <span ng-if="glyphicon != null" class="glyphicon glyphicon-{{glyphicon}}"></span>
        <content></content>
    </button>
    """,
    useShadowDom: false,
    map: const{
      "glyphicon": "@glyphicon",
      "tooltipText": "@tooltip",
      "primary": "@primary",
      "enabled": "=>enabled",
    }
)
class DimeButton {
  String glyphicon = null;
  String tooltip = null;
  String primary = null;
  bool enabled = true;

  getClass(){
    if(primary == null){
      return "btn btn-default";
    } else {
      return "btn btn-primary";
    }
  }
}
