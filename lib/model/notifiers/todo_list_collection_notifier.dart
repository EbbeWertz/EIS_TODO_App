import 'package:eis_todo_app/model/database/repositories/todo_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:eis_todo_app/model/data_models/todo_list.dart';

class TodoListCollectionNotifier extends ChangeNotifier {
  final TodoListRepository _repo;

  List<TodoList> _lists = [];
  List<TodoList> get lists => List.unmodifiable(_lists);

  TodoListCollectionNotifier(this._repo) {
    // database is reactive: notifyListeners gebeurt dus als de database update
    _repo.watchLists().listen((lists) {
      _lists = lists;
      notifyListeners();
    });
  }

  Future<void> addList(String name, int colorId, int iconId) async {
    _repo.addList(name, colorId, iconId);
  }

  Future<void> updateList(String id, String name, int colorId, int iconId) async {
    _repo.updateList(id, name, colorId, iconId);
  }

  Future<void> removeList(String listId) async {
    _repo.removeList(listId);
  }

  Future<void> reOrderLists(int oldIndex, int newIndex) async {
    // dummy re-order zodat de UI wel al kan updaten
    final moved = _lists.removeAt(oldIndex);
    _lists.insert(newIndex, moved);
    notifyListeners();

    _repo.reorderLists(oldIndex, newIndex);
  }


}
