import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoListNotifier = context.watch<TodoListNotifier>();
    final activeTodos = todoListNotifier.activeTodos;
    final completedTodos = todoListNotifier.completedTodos;

    if (activeTodos.isEmpty && completedTodos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Text(
            'You don\'t have any TODOs in this list.\n\nAdd one with the + button!',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ReorderableListView(
      padding: const EdgeInsets.all(16),
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex -= 1;
        todoListNotifier.reorderActiveTodo(oldIndex, newIndex);
      },
      proxyDecorator: (child, index, animation) {
        return Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 4,
          color: Colors.transparent,
          shadowColor: Colors.black26,
          child: child,
        );
      },
      children: [
        for (int i = 0; i < activeTodos.length; i++)
          TodoTile(
            key: ValueKey(activeTodos[i].id),
            todo: activeTodos[i],
            index: i,
            colorId: todoListNotifier.todoList!.color,
            todoListNotifier: todoListNotifier,
          ),
        if (completedTodos.isNotEmpty)
          ExpansionTile(
            key: const ValueKey('completed'),
            title: Text(
              'Completed (${completedTodos.length})',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            children: [
              for (int i = 0; i < completedTodos.length; i++)
                TodoTile(
                  key: ValueKey(completedTodos[i].id),
                  todo: completedTodos[i],
                  index: i,
                  colorId: todoListNotifier.todoList!.color,
                  todoListNotifier: todoListNotifier,
                ),
            ],
          ),
      ],
    );
  }
}
