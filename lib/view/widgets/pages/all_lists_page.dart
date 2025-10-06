import 'package:eis_todo_app/model/notifiers/todo_lists_notifier.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/color_selector.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/icon_selector.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_lists_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllListsPage extends StatelessWidget {
  const AllListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoLists = context.watch<TodoListsNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Todo Lists'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: TodoListsView(todoLists: todoLists),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddListDialog(context),
        tooltip: 'Add List',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddListDialog(BuildContext context) {
    final nameController = TextEditingController();
    IconData selectedIcon = Icons.list;
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('New List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'List name'),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconSelector(
                    value: selectedIcon,
                    onChanged: (icon) => setState(() => selectedIcon = icon),
                  ),
                  const SizedBox(width: 16),
                  ColorSelector(
                    value: selectedColor,
                    onChanged: (color) => setState(() => selectedColor = color),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  context.read<TodoListsNotifier>().addList(
                    name,
                    selectedColor,
                    selectedIcon,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
