import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../pipe/selected_tags_pipe.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';

@Component(
  selector: 'tag-select',
  templateUrl: 'tag_select_component.html',
  directives: const [formDirectives, coreDirectives],
  pipes: const [dimePipes, SelectedTagsPipe],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, TagSelectComponent, multi: true)],
)
class TagSelectComponent implements OnInit, ControlValueAccessor<List<Tag>> {
  ChangeFunction<List<Tag>> onChange;

  List<Tag> selectedEntities = [];

  StatusService statusservice;

  List<Tag> entities;

  CachingObjectStoreService store;

  // window
  String selector = '';
  bool open = false;
  @Input()
  bool disabled = false;

  @ViewChild('input')
  HtmlElement input;

  TagSelectComponent(this.statusservice, this.store);

  Future reload() async {
    await this.statusservice.run(() async {
      this.entities = (await this.store.list<Tag>(Tag)).toList();
    });
  }

  void select(Tag tag) {
    if (selectedEntities.where((Tag t) => t.id == tag.id).isEmpty) {
      selectedEntities.add(tag);
      onChange(selectedEntities);
    }
    open = false;
  }

  void delete(Tag tag) {
    if (window.confirm('Wirklich löschen?') && selectedEntities.where((Tag t) => t.id == tag.id).isNotEmpty) {
      selectedEntities.removeWhere((Tag t) => t.id == tag.id);
      onChange(selectedEntities);
    }
  }

  toggleOpen() async {
    open = !open;
    await new Future<dynamic>.delayed(const Duration(microseconds: 1));
    if (open) {
      (input as InputElement).focus();
    }
  }

  @override
  void registerOnChange(ChangeFunction<List<Tag>> f) {
    this.onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {
    //don't care, for now
  }

  @override
  void writeValue(List<Tag> obj) {
    this.selectedEntities = obj;
  }

  @override
  ngOnInit() {
    reload();
  }

  @override
  void onDisabledChanged(bool isDisabled) {
    // TODO: implement onDisabledChanged
  }
}
