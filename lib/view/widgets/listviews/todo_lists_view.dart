import 'package:eis_todo_app/model/notifiers/todo_list_collection_notifier.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_list_tile.dart';
import 'package:flutter/material.dart';

class TodoListsView extends StatelessWidget {

  final TodoListCollectionNotifier todoListsNotifier;
  const TodoListsView({super.key, required this.todoListsNotifier});

  @override
  Widget build(BuildContext context) {
    final lists = todoListsNotifier.lists;
    if (lists.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            'No lists yet.\nTap + to add one!',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return ReorderableListView(
      padding: const EdgeInsets.all(16),
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex -= 1;
        todoListsNotifier.reOrderLists(oldIndex, newIndex);
      },
      children: [
        for (int i = 0; i < lists.length; i++)
          TodoListTile(key: ValueKey(lists[i].id), list: lists[i], index: i),
      ],
      // proxyDecorator = vorm voor de schaduw als de tile ge-dragged word
      // default vorm = een rectangle box, wat niet aansluit bij de tile shape
      proxyDecorator: (child, index, animation) {
        return Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 4,
          color: Colors.transparent,
          shadowColor: Colors.black26,
          child: child,
        );
      },
    );
  }

}
