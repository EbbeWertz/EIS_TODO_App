import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TodoDetailSheet {
  static void show(BuildContext context, Todo todo) {
    final todoList = context.read<TodoListNotifier>();
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: viewInsets, left: 16, right: 16, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(todo.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (todo.description != null && todo.description!.isNotEmpty)
                Text(todo.description!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      todoList.removeTodo(todo);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      todoList.toggleTodoStatus(todo);
                      Navigator.pop(context);
                    },
                    icon: Icon(todo.completed ? Icons.undo : Icons.check),
                    label: Text(todo.completed ? 'Mark Undone' : 'Mark Done'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
