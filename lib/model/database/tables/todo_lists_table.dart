import 'package:drift/drift.dart';

class TodoListsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get color => integer()();
  IntColumn get icon => integer()();
  IntColumn get position => integer()();
}