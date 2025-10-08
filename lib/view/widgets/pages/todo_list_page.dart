import 'package:eis_todo_app/model/database/repositories/todo_list_repository.dart';
import 'package:eis_todo_app/model/database/repositories/todo_repository.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_collection_notifier.dart';
import 'package:eis_todo_app/view/modals/add_todo_sheet.dart';
import 'package:eis_todo_app/view/todo_color.dart';
import 'package:eis_todo_app/view/todo_icon.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dialog_components/add_list_dialog.dart' show AddListDialog;
class TodoListPage extends StatelessWidget {
  final String listId;

  const TodoListPage({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    final todoRepo = context.read<TodoRepository>();
    final todoListRepo = context.read<TodoListRepository>();
    final todoListsNotifier = context.read<TodoListCollectionNotifier>();

    return ChangeNotifierProvider(
      create: (_) => TodoListNotifier(todoRepo, todoListRepo, listId),
      child: Consumer<TodoListNotifier>(
        builder: (context, notifier, _) {
          final todoList = notifier.todoList; // reactive
          if (todoList == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final color = TodoColor.fromColorId(todoList.color).materialColor;
          final icon = TodoIcon.fromIconId(todoList.icon).materialIconData;

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 16),
                  Text(todoList.name),
                ],
              ),
              backgroundColor: ColorScheme.fromSeed(
                seedColor: color,
                brightness: Theme.of(context).brightness,
              ).inversePrimary,
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      _confirmDelete(context, todoListsNotifier);
                    } else if (value == "edit"){
                      AddListDialog(title: "Edit List", existingList: todoList).show(context);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete List',
                          style: TextStyle(color: Colors.red)),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit List'),
                    ),
                  ],
                ),
              ],
            ),
            body: const TodoListView(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => AddTodoSheet(notifier).show(context),
              tooltip: 'Add Todo',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, TodoListCollectionNotifier todoListsCollectionNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete List?'),
        content: const Text(
            'Are you sure you want to delete this list? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await todoListsCollectionNotifier.removeList(listId);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
