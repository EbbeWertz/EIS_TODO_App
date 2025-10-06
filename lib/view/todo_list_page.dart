import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/model/notifiers/todo_lists_notifier.dart';
import 'package:eis_todo_app/view/widgets/add_todo_sheet.dart';
import 'package:eis_todo_app/view/widgets/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  final String listName;

  const TodoListPage({super.key, required this.listName});

  @override
  Widget build(BuildContext context) {
    final collection = context.read<TodoListsNotifier>();
    final todoList = collection.getList(listName);

    if (todoList == null) {
      return const Scaffold(
        body: Center(child: Text('List not found')),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => TodoListNotifier(todoList),
      child: Scaffold(
        appBar: AppBar(
          title: Text(listName),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  _confirmDelete(context, collection);
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

  void _confirmDelete(BuildContext context, TodoListsNotifier collection) {
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
              collection.removeList(listName);
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
