import 'todo_list.dart';

class TodoListCollection {
  final List<TodoList> _lists = [];

  List<TodoList> get lists => List.unmodifiable(_lists);

}
