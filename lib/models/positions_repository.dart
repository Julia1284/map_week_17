import 'package:map_week_17/models/position.dart';
import 'package:map_week_17/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  ObjectBox._create(this.store);
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
}

class NotesRepository {
  final _position = <Position>[];

  List<Position> get position => _position;

  void addNote(Position position) {
    _position.add(position);
  }
}
