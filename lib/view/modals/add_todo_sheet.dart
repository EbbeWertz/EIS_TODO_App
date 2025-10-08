import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoSheet {
  TodoListNotifier todoListNotifier;

  AddTodoSheet(this.todoListNotifier);

  void show(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final viewInsets = MediaQuery.of(context).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.only(bottom: viewInsets, left: 16, right: 16, top: 16),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'What do you need to do?',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _addTodo(context, titleController, descController, todoListNotifier),
                  ),
                  TextField(
                    controller: descController,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Add a short description (optional)',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              Positioned(
                bottom: 12,
                right: 8,
                child: FloatingActionButton.small(
                  onPressed: () => _addTodo(context, titleController, descController, todoListNotifier),
                  tooltip: 'Add Todo',
                  child: const Icon(Icons.check),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _addTodo(BuildContext context, TextEditingController titleController,
      TextEditingController descController, TodoListNotifier notifier) {
    final title = titleController.text.trim();
    final desc = descController.text.trim();
    if (title.isNotEmpty) {
      notifier.addTodo(title, desc.isNotEmpty ? desc : null);
      Navigator.pop(context);
    }
  }
}
