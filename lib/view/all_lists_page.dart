import 'package:eis_todo_app/model/notifiers/todo_lists_notifier.dart';
import 'package:eis_todo_app/view/todo_list_page.dart';
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final list in todoLists.lists)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Material(
                color: ColorScheme.fromSeed(
                  seedColor: list.color,
                  brightness: Theme.of(context).brightness,
                ).surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  leading: Icon(list.icon, color: list.color),
                  title: Text(list.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TodoListPage(listName: list.name),
                      ),
                    );
                  },
                ),
              ),
            ),
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
      ),
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
                  // Icon picker (simplified)
                  DropdownButton<IconData>(
                    value: selectedIcon,
                    items: [
                      Icons.list,
                      Icons.work,
                      Icons.shopping_cart,
                      Icons.school,
                      Icons.home,
                      Icons.fitness_center,
                      Icons.book,
                      Icons.restaurant,
                      Icons.flight,
                      Icons.movie,
                      Icons.music_note,
                      Icons.pets,
                    ]
                        .map((icon) => DropdownMenuItem(
                      value: icon,
                      child: Icon(icon),
                    ))
                        .toList(),
                    onChanged: (icon) => setState(() {
                      if (icon != null) selectedIcon = icon;
                    }),
                  ),
                  const SizedBox(width: 16),
                  // Color picker (simplified)
                  DropdownButton<Color>(
                    value: selectedColor,
                    items: [
                      Colors.red,
                      Colors.pink,
                      Colors.purple,
                      Colors.deepPurple,
                      Colors.indigo,
                      Colors.blue,
                      Colors.lightBlue,
                      Colors.cyan,
                      Colors.teal,
                      Colors.green,
                      Colors.lime,
                      Colors.yellow,
                    ]
                        .map((color) => DropdownMenuItem(
                      value: color,
                      child: Container(
                        width: 24,
                        height: 24,
                        color: color,
                      ),
                    ))
                        .toList(),
                    onChanged: (color) => setState(() {
                      if (color != null) selectedColor = color;
                    }),
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
