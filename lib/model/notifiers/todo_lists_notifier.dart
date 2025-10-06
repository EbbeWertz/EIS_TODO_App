import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:eis_todo_app/model/data_models/todo_lists.dart';
import 'package:flutter/material.dart';

class TodoListsNotifier extends ChangeNotifier {
  final TodoLists _model = TodoLists();

  List<TodoList> get lists => _model.lists;

  void addList(String name, Color color, IconData? icon) {
    _model.addList(name, color, (icon ?? Icons.list));
    notifyListeners();
  }
  void removeList(TodoList list) {
    _model.removeList(list);
    notifyListeners();
  }

  void reOrderLists(int fromIndex, int toIndex){
    _model.reOrderLists(fromIndex, toIndex);
    notifyListeners();
  }
}
