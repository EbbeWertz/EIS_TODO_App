import 'package:eis_todo_app/model/notifiers/todo_list_collection_notifier.dart';
import 'package:eis_todo_app/view/todo_color.dart';
import 'package:eis_todo_app/view/todo_icon.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/color_selector.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/icon_selector.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_lists_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllListsPage extends StatelessWidget {
  const AllListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoListsNotifier = context.watch<TodoListCollectionNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Todo Lists'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: TodoListsView(todoListsNotifier: todoListsNotifier),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddListDialog(context),
        tooltip: 'Add List',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddListDialog(BuildContext context) {
    final nameController = TextEditingController();
    TodoIcon selectedIcon = TodoIcon.fromIconId(0);
    TodoColor selectedColor = TodoColor.fromColorId(0);

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('New List'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField( controller: nameController, decoration: const InputDecoration(hintText: 'List name'), autofocus: true, ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 40,
                        child: IconSelector(
                          value: selectedIcon,
                          onChanged: (icon) => setState(() => selectedIcon = icon),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 40,
                        child: ColorSelector(
                          value: selectedColor,
                          onChanged: (color) => setState(() => selectedColor = color),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                  context.read<TodoListCollectionNotifier>().addList(
                    name,
                    selectedColor.id,
                    selectedIcon.id,
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
