import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:eis_todo_app/model/data_models/todo_lists.dart';
import 'package:flutter/material.dart';

class TodoListsNotifier extends ChangeNotifier {
  final TodoLists _model = TodoLists();

  List<TodoList> get lists => _model.lists;

  TodoList? getList(String name) => _model.getList(name);

  void addList(String name, Color color, IconData? icon) {
    _model.addList(name, color, (icon ?? Icons.list));
    notifyListeners();
  }

  void removeList(String name) {
    _model.removeList(name);
    notifyListeners();
  }
}
