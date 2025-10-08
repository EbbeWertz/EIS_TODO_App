import 'package:drift/drift.dart';
import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:eis_todo_app/model/database/todo_database.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  final TodoDatabase db;
  final _uuid = const Uuid();

  TodoRepository(this.db);

  Todo _fromDb(TodosTableData row) {
    return Todo(
      id: row.id,
      title: row.title,
      description: row.description,
      completed: row.completed,
      position: row.position,
    );
  }

  // Todos stream
  Stream<List<Todo>> watchTodosForList(String listId) {
    final query = db.select(db.todosTable)..where((tbl) => tbl.listId.equals(listId))..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]);
    return query.watch().map((rows) => rows.map(_fromDb).toList());
  }

  Future<void> addTodo(String listId, String title, [String? description]) async {
    final position = await db.todosTable.count().getSingle();
    await db.into(db.todosTable).insert(TodosTableCompanion.insert(
      id: _uuid.v4(),
      listId: listId,
      title: title,
      description: Value(description),
      completed: const Value(false),
      position: position,
    ));
  }

  Future<void> removeTodo(String id) =>
      (db.delete(db.todosTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> toggleTodo(String id, bool newValue) async {
    await (db.update(db.todosTable)..where((tbl) => tbl.id.equals(id)))
        .write(TodosTableCompanion(completed: Value(newValue)));
  }

  Future<void> reorderTodo(String listId, int oldIndex, int newIndex) async {
    final todosQuery = db.select(db.todosTable)..where((t) => t.listId.equals(listId))..orderBy([(t) => OrderingTerm.asc(t.position)]);
    final todos = await todosQuery.get();

    // Reorder
    final moved = todos.removeAt(oldIndex);
    todos.insert(newIndex, moved);

    // update positions
    await db.batch((b) {
      for (int i = 0; i < todos.length; i++) {
        b.update(
          db.todosTable,
          TodosTableCompanion(position: Value(i)),
          where: (t) => t.id.equals(todos[i].id),
        );
      }
    });
  }
}
