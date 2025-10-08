import 'package:drift/drift.dart';
import 'package:eis_todo_app/model/database/tables/todo_lists_table.dart';

class TodosTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get listId => text().references(TodoListsTable, #id)();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  IntColumn get position => integer()();
  BoolColumn get favourite => boolean().withDefault(Constant(false))();
  DateTimeColumn get deadline => dateTime().nullable()();
}