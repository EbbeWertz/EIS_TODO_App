import 'package:drift/drift.dart';
import 'package:eis_todo_app/model/database/tables/todo_lists_table.dart';
import 'package:eis_todo_app/model/database/tables/todos_table.dart';

part 'todo_database.g.dart';

// database code moet generated worden met:
// dart run build_runner build

// dev mode:
// dart run build_runner watch

@DriftDatabase(tables: [TodoListsTable, TodosTable])
class TodoDatabase extends _$TodoDatabase {
  TodoDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
