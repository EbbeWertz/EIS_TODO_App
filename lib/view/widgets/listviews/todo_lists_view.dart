import 'package:eis_todo_app/model/notifiers/todo_lists_notifier.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_list_tile.dart';
import 'package:flutter/material.dart';

class TodoListsView extends StatelessWidget {
  const TodoListsView({super.key, required this.todoLists});

  final TodoListsNotifier todoLists;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final list in todoLists.lists) TodoListTile(list: list),
        if (todoLists.lists.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'No lists yet.\nTap + to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}
