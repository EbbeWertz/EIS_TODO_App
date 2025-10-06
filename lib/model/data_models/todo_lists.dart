import 'todo_list.dart';
import 'package:flutter/material.dart';

class TodoLists {
  final List<TodoList> _lists = [];

  List<TodoList> get lists => List.unmodifiable(_lists);

  void addList(String name, Color color, IconData icon) {
    _lists.insert(0, TodoList(name: name, color: color, icon: icon));
  }

  void removeList(TodoList todoList) {
    _lists.remove(todoList);
  }

  void reOrderLists(int fromIndex, int toIndex){
    TodoList item = _lists.removeAt(fromIndex);
    _lists.insert(toIndex, item);
  }

}
