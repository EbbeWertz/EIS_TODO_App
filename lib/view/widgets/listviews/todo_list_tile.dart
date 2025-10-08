import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:eis_todo_app/view/todo_color.dart';
import 'package:eis_todo_app/view/todo_icon.dart';
import 'package:eis_todo_app/view/widgets/pages/todo_list_page.dart';
import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({super.key, required this.list, required this.index});

  final TodoList list;
  final int index; // needed for drag listener

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: ColorScheme.fromSeed(
          seedColor: TodoColor.fromColorId(list.color).materialColor,
          brightness: Theme.of(context).brightness,
        ).surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Icon(Icons.drag_indicator, color: Theme.of(context).iconTheme.color?.withAlpha(16)),
              ),
              const SizedBox(width: 8),
              Icon(TodoIcon.fromIconId(list.icon).materialIconData, color: TodoColor.fromColorId(list.color).materialColor),
            ],
          ),
          title: Text(list.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TodoListPage(listId: list.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
