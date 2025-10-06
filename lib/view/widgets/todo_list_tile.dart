import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:eis_todo_app/view/widgets/todo_detail_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TodoListTile extends StatelessWidget {
  final Todo todo;

  const TodoListTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final todoList = context.read<TodoListNotifier>();

    return ListTile(
      key: ValueKey(todo.id),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (_) => todoList.toggleTodoStatus(todo),
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
    );
  }
}
