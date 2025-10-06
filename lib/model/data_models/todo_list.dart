import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:flutter/material.dart';


class TodoList {
  final String id;
  final List<Todo> _activeTodos;
  final List<Todo> _completedTodos;
  final IconData icon;
  final Color color;
  final String name;

  TodoList({required this.name, required this.color, required this.icon}): _activeTodos = [], _completedTodos = [], id = UniqueKey().toString();

  List<Todo> get activeTodos => List.unmodifiable(_activeTodos);
  List<Todo> get completedTodos => List.unmodifiable(_completedTodos);
  List<Todo> get allTodos => [..._activeTodos, ..._completedTodos];

  void addTodo(String title, [String? description]) {
    _activeTodos.insert(0, Todo(title: title, description: description));
  }

  void removeTodo(Todo todo) {
    // er is geen effect als die niet bestond in de lijst -> kan dus van beide lijsten removen
    _activeTodos.remove(todo);
    _completedTodos.remove(todo);
  }

  void toggleTodoStatus(Todo todo) {
    final initiallyActive = !todo.completed;
    todo.toggleCompleted();
    if (initiallyActive){
      _activeTodos.remove(todo);
      _completedTodos.add(todo);
    } else {
      _completedTodos.remove(todo);
      _activeTodos.add(todo);
    }
  }

  void reorderActiveTodo(int oldIndex, int newIndex) {
    final todo = _activeTodos.removeAt(oldIndex);
    _activeTodos.insert(newIndex, todo);
  }
}
