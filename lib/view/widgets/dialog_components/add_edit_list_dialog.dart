import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_collection_notifier.dart';
import 'package:eis_todo_app/view/todo_color.dart';
import 'package:eis_todo_app/view/todo_icon.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/color_selector.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/icon_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOrEditListDialog{

  final String title;
  final TodoList? existingList;

  AddOrEditListDialog({required this.title, this.existingList});

  void show(BuildContext context) {
    final nameController = TextEditingController(
      text: existingList?.name ?? '',
    );
    TodoIcon selectedIcon = TodoIcon.fromIconId(existingList?.icon ?? 0);
    TodoColor selectedColor = TodoColor.fromColorId(existingList?.color ?? 0);

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(title),
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
                  if(existingList == null) {
                    context.read<TodoListCollectionNotifier>().addList(
                      name,
                      selectedColor.id,
                      selectedIcon.id,
                    );
                  } else {
                    context.read<TodoListCollectionNotifier>().updateList(
                      existingList!.id,
                      name,
                      selectedColor.id,
                      selectedIcon.id,
                    );
                  }
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