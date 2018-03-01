import 'package:angular/angular.dart';

@Component(
  selector: 'help-tooltip',
  template: '<i class="fa fa-info-circle control-label" data-toggle="tooltip" title="{{text}}"></i>',
)
class HelpTooltip {
  @Input()
  String text = "gurken";

  getText() {
    return this.text;
  }
}
