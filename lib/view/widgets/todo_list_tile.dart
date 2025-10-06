import 'package:eis_todo_app/model/data_models/todo_list.dart';
import 'package:eis_todo_app/view/todo_list_page.dart';
import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({super.key, required this.list});

  final TodoList list;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
