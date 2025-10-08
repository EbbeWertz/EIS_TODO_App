import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_collection_notifier.dart';
import 'package:eis_todo_app/view/modals/add_todo_sheet.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  final TodoList todoList;

  const TodoListPage({super.key, required this.todoList});

  @override
  Widget build(BuildContext context) {
    final todoLists = context.read<TodoListCollectionNotifier>();

    return ChangeNotifierProvider(
      create: (_) => TodoListNotifier(todoList),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(todoList.icon),
              const SizedBox(width: 16),
              Text(todoList.name),
            ],
          ),
          backgroundColor: ColorScheme.fromSeed(
            seedColor: todoList.color,
            brightness: Theme.of(context).brightness,
          ).inversePrimary,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  _confirmDelete(context, todoLists);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete List', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
        body: const TodoListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AddTodoSheet.show(context),
          tooltip: 'Add Todo',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, TodoListCollectionNotifier todoLists) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete List?'),
        content: const Text('Are you sure you want to delete this list? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              todoLists.removeList(todoList);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous page
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
