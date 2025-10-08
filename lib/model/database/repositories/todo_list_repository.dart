import 'package:drift/drift.dart';
import 'package:eis_todo_app/model/database/todo_database.dart';
import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:uuid/uuid.dart';

class TodoListRepository {
  final TodoDatabase db;
  final _uuid = const Uuid();

  TodoListRepository(this.db);

  TodoList _fromDb(TodoListsTableData row) {
    return TodoList(
      id: row.id,
      name: row.name,
      color: row.color,
      icon: row.icon,
      position: row.position,
    );
  }

  // TodoLists stream
  Stream<List<TodoList>> watchLists() {
    // get all todolists, pre-ordered op de position
    final query = db.select(db.todoListsTable)..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]);
    return query.watch().map((rows) => rows.map(_fromDb).toList());
  }

  Future<void> addList(String name, int colorId, int iconId) async {
    final countExpr = db.todoListsTable.id.count();
    final query = db.selectOnly(db.todoListsTable)..addColumns([countExpr]);
    final result = await query.getSingle();
    final count = result.read(countExpr) ?? 0;

    await db.into(db.todoListsTable).insert(TodoListsTableCompanion.insert(
      id: _uuid.v4(),
      name: name,
      color: colorId,
      icon: iconId,
      position: count,
    ));
  }

  Future<void> removeList(TodoList list) =>
      (db.delete(db.todoListsTable)..where((tbl) => tbl.id.equals(list.id))).go();

  Future<void> reorderLists(List<TodoList> lists, int oldIndex, int newIndex) async {
    final moved = lists.removeAt(oldIndex);
    lists.insert(newIndex, moved);
    for (int i = 0; i < lists.length; i++) {
      await (db.update(db.todoListsTable)..where((tbl) => tbl.id.equals(lists[i].id)))
          .write(TodoListsTableCompanion(position: Value(i)));
    }
  }
}
