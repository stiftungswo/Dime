import 'package:angular/angular.dart';
import 'dart:async';

@Injectable()
class EntityEventsService {
  final StreamController<EntityEvent> _changeStreamController = new StreamController<EntityEvent>.broadcast();

  Stream<EntityEvent> get _stream => _changeStreamController.stream;

  void emitSaveChanges() {
    emit(EntityEvent.SAVE_CHANGES);
  }

  StreamSubscription<EntityEvent> addSaveChangesListener(void listener()) {
    return addListener(EntityEvent.SAVE_CHANGES, listener);
  }

  void emit(EntityEvent event) {
    _changeStreamController.add(event);
  }

  StreamSubscription<EntityEvent> addListener(EntityEvent event, void listener()) {
    return _stream.where((eventName) => eventName == event).listen((_) => listener());
  }
}

enum EntityEvent { SAVE_CHANGES, RATE_GROUP_CHANGED }
