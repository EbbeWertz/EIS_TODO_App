import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:eis_todo_app/model/database/tables/todo_lists_table.dart';
import 'package:eis_todo_app/model/database/tables/todos_table.dart';
import 'package:path_provider/path_provider.dart';

part 'todo_database.g.dart';

// database code moet generated worden met:
// dart run build_runner build

// dev mode:
// dart run build_runner watch

@DriftDatabase(tables: [TodoListsTable, TodosTable])
class TodoDatabase extends _$TodoDatabase {
  TodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'todo_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
