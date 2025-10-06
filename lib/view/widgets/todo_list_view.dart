import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/view/widgets/todo_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoList = context.watch<TodoListNotifier>();
    final activeTodos = todoList.activeTodos;
    final completedTodos = todoList.completedTodos;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (activeTodos.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                completedTodos.isEmpty
                ? 'You don\'t have any TODOs in this list.\n\nAdd one with the + button!'
                : 'You have completed all your TODOs ✅',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ...activeTodos.map((todo) => TodoListTile(todo: todo)),
        if (completedTodos.isNotEmpty) ...[
          const SizedBox(height: 16),
          ExpansionTile(
            title: Text(
              'Completed (${completedTodos.length})',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            children: completedTodos.map((todo) => TodoListTile(todo: todo)).toList(),
          ),
        ],
      ],
    );
  }
}
