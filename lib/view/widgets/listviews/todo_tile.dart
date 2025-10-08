import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/view/modals/todo_detail_sheet.dart';
import 'package:eis_todo_app/view/todo_color.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {

  final Todo todo;
  final int index;
  final int colorId;
  final TodoListNotifier todoListNotifier;

  const TodoTile({super.key, required this.todo, required this.index, required this.colorId, required this.todoListNotifier});

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
          leading: Checkbox(
            value: todo.completed,
            onChanged: (_) => todoListNotifier.toggleTodoStatus(todo),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: todo.description != null
              ? Text(
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
          )
              : null,
          onTap: () => TodoDetailSheet.show(context, todo),
        ),
      ),
    );
  }
}
