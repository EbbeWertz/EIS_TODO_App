import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/view/modals/add_todo_sheet.dart';
import 'package:eis_todo_app/view/modals/todo_detail_sheet.dart';
import 'package:eis_todo_app/view/todo_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final int index;
  final int colorId;
  final TodoListNotifier todoListNotifier;

  const TodoTile({
    super.key,
    required this.todo,
    required this.index,
    required this.colorId,
    required this.todoListNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = TodoColor.fromColorId(colorId).materialColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: ColorScheme.fromSeed(
          seedColor: tileColor,
          brightness: Theme.of(context).brightness,
        ).surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          key: ValueKey(todo.id),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Icon(
                  Icons.drag_indicator,
                  color: Theme.of(context).iconTheme.color?.withAlpha(16),
                ),
              ),
              const SizedBox(width: 8),
              Checkbox(
                value: todo.completed,
                onChanged: (_) => todoListNotifier.toggleTodoStatus(todo),
              ),
            ],
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todo.description != null && todo.description!.isNotEmpty)
                Text(
                  todo.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: todo.completed
                        ? Colors.grey
                        : Theme.of(context).textTheme.bodySmall?.color,
                    decoration: todo.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
              if (todo.deadline != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd/MM').format(todo.deadline!),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              todo.favourite ? Icons.star : Icons.star_outline,
              color: todo.favourite ? Colors.amber : Colors.grey,
            ),
            onPressed: () {
              todoListNotifier.updateTodoFavourite(todo, !todo.favourite);
            },
          ),
          onTap: () {
            TodoAddOrEditSheet(todoListNotifier, todo).show(context);
          },
        ),
      ),
    );
  }
}
