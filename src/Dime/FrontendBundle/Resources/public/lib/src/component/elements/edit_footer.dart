import 'package:DimeClient/src/model/Entity.dart';
import 'package:angular/angular.dart';

@Component(
    selector: "edit-footer",
    template: """
    <footer *ngIf="entity?.updatedAt != null">
      <div class="text-muted pull-right">
        <small>
          Letzte Änderung: {{(entity.user != null ? entity.user.firstname + ' ' + entity.user.lastname + ', ' : '' )+ entity.updatedAt.toString()}},
          Erstellt am: {{entity.createdAt.toString()}}
        </small>
      </div>
    </footer>
  """,
    directives: const [CORE_DIRECTIVES])
class EditFooterComponent {
  @Input()
  Entity entity;
}
