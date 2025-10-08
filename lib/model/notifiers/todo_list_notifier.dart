import 'package:eis_todo_app/model/database/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:eis_todo_app/model/data_models/todo.dart';

class TodoListNotifier extends ChangeNotifier {
  final TodoRepository _repo;
  final String listId;

  List<Todo> _todos = [];
  List<Todo> get activeTodos => _todos.where((t) => !t.completed).toList(growable: false);
  List<Todo> get completedTodos => _todos.where((t) => t.completed).toList(growable: false);
  List<Todo> get allTodos => List.unmodifiable(_todos);

  TodoListNotifier(this._repo, this.listId) {
    // database is reactive: notifyListeners gebeurt dus als de database update
    _repo.watchTodosForList(listId).listen((todos) {
      _todos = todos;
      notifyListeners();
    });
  }

  Future<void> addTodo(String title, [String? description]) async {
    _repo.addTodo(listId, title, description);
  }


  Future<void> removeTodo(Todo todo) async {
    _repo.removeTodo(todo.id);
  }
  Future<void> toggleTodoStatus(Todo todo) async {
    _repo.toggleTodo(todo.id, !todo.completed);
  }

  Future<void> reorderActiveTodo(int oldIndex, int newIndex) async {
    final active = activeTodos;
    final moved = active.removeAt(oldIndex);
    active.insert(newIndex, moved);
    await _repo.reorderTodo(listId, oldIndex, newIndex);
  }

}
