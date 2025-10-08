import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:eis_todo_app/model/database/repositories/todo_list_repository.dart';
import 'package:eis_todo_app/model/database/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:eis_todo_app/model/data_models/todo.dart';

class TodoListNotifier extends ChangeNotifier {
  final TodoRepository _todoRepo;
  final TodoListRepository _listRepo;
  final String listId;

  TodoList? _todoList;
  List<Todo> _todos = [];

  TodoList? get todoList => _todoList;
  List<Todo> get activeTodos => _todos.where((t) => !t.completed).toList(growable: false);
  List<Todo> get completedTodos => _todos.where((t) => t.completed).toList(growable: false);
  List<Todo> get allTodos => List.unmodifiable(_todos);

  TodoListNotifier(this._todoRepo, this._listRepo, this.listId) {
    // database is reactive: notifyListeners gebeurt dus als de database update
    _todoRepo.watchTodosForList(listId).listen((todos) {
      _todos = todos;
      notifyListeners();
    });
    _listRepo.watchListById(listId).listen((list) {
      _todoList = list;
      notifyListeners();
    });
  }

  Future<void> addTodo(String title, [String? description]) async {
    _todoRepo.addTodo(listId, title, description);
  }


  Future<void> removeTodo(Todo todo) async {
    _todoRepo.removeTodo(todo.id);
  }
  Future<void> toggleTodoStatus(Todo todo) async {
    _todoRepo.toggleTodo(todo.id, !todo.completed);
  }

  Future<void> reorderActiveTodo(int oldIndex, int newIndex) async {
    // dummy re-order zodat de UI wel al kan updaten
    final active = activeTodos;
    final moved = active.removeAt(oldIndex);
    active.insert(newIndex, moved);
    notifyListeners();

    await _todoRepo.reorderTodo(listId, oldIndex, newIndex);
  }

}
