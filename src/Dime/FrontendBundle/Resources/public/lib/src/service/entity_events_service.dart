import 'package:angular/angular.dart';
import 'dart:async';

@Injectable()
class EntityEventsService {
  final StreamController<String> _changeStreamController = new StreamController<String>.broadcast();

  Stream<String> get _stream => _changeStreamController.stream;

  void emitSaveChanges() {
    _changeStreamController.add('saveChanges');
  }

  StreamSubscription<String> addSaveChangesListener(void listener()) {
    return _stream.where((eventName) => eventName == 'saveChanges').listen((_) => listener());
  }
}
