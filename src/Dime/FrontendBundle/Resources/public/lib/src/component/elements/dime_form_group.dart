import 'dart:developer';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

/// This component can display validation errors from its ng-content.
///
/// Be sure to add a child component that implements [Validatable] and provides correctly:
///
///
///     @Component(
///       selector: "foo",
///       providers: const [const Provider(Validatable, useExisting: Foo)]
///     )
///     class Foo extends BaseFoo with Validatable{
///
@Component(
  selector: "dime-form-group",
  template: """
    <div class='form-group' [class.has-error]='validatable != null && validatable.valid != null && !validatable.valid'>
      <label [attr.for]="eId != null ? eId : label"
             class="control-label"
             [class.col-sm-2]="horizontal"
      >{{label}}</label>
      <div [class.col-sm-4]="horizontal">
        <ng-content></ng-content>
      </div>
      <ul *ngIf='validatable != null' class='help-block'>
        <li *ngIf="validatable.errors['required'] == true">
          <i class="fa fa-times"></i>
          Dieses Feld darf nicht leer sein
        </li>
      </ul>
    </div>
  """,
  directives: const [CORE_DIRECTIVES]
)
class DimeFormGroup implements AfterViewInit{
  @ContentChild(Validatable) Validatable validatable;

  @Input() bool horizontal = false;
  @Input() String label;
  String eId = null;

  printErrors(){
    print(validatable.errors);
  }

  @override
  ngAfterViewInit() {
    if(validatable == null){
      //TODO: debug comment; remove
      print("validatable is null");
    } else {
      print("validatable is SET!");
    }
  }
}

//TODO move this into a seperate file
abstract class Validatable{
  Map<String, dynamic> get errors;
  bool get valid;
}

class ValidatableNgForm implements Validatable{
  @ViewChild(NgControl) NgControl control;
  final Map<String, dynamic> _empty = {};

  Map<String,dynamic> get _errors{
    if(control == null){
      return _empty;
    } else {
      return control.errors == null ? _empty : control.errors;
    }
  }

  @override Map<String,dynamic> get errors => _errors;
  @override bool get valid => control != null ? control.valid : true;
}

class ValidatableCustom implements Validatable{
  Map<String, dynamic> _errors = {};
  Map<String, dynamic> get errors => _errors;
  bool get valid => _errors.values.where((msg)=> msg!=null && msg.toString().isNotEmpty).isEmpty;
}
