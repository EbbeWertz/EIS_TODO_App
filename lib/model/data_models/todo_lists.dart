import 'todo_list.dart';
import 'package:flutter/material.dart';

class TodoLists {
  final Map<String, TodoList> _lists = {};

  List<String> get listNames => _lists.keys.toList();

  List<TodoList> get lists => List.unmodifiable(_lists.values);

  TodoList? getList(String name) => _lists[name];

  void addList(String name, Color color, IconData icon) {
    if (!_lists.containsKey(name)) {
      _lists[name] = TodoList(name: name, color: color, icon: icon);
    }
  }

  void removeList(String name) {
    _lists.remove(name);
  }
}
