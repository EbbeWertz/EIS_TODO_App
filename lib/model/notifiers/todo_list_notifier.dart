import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:flutter/material.dart';

class TodoListNotifier extends ChangeNotifier {
  final TodoList _todoList;

  TodoListNotifier(this._todoList);

  List<Todo> get activeTodos => _todoList.activeTodos;
  List<Todo> get completedTodos => _todoList.completedTodos;
  List<Todo> get allTodos => _todoList.allTodos;

  void addTodo(String title, [String? description]) {
    _todoList.addTodo(title, description);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todoList.removeTodo(todo);
    notifyListeners();
  }

  void toggleTodoStatus(Todo todo) {
    _todoList.toggleTodoStatus(todo);
    notifyListeners();
  }

  void reorderActiveTodo(int oldIndex, int newIndex) {
    _todoList.reorderActiveTodo(oldIndex, newIndex);
    notifyListeners();
  }
}
