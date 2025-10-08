import 'package:eis_todo_app/model/notifiers/todo_list_collection_notifier.dart';
import 'package:eis_todo_app/view/todo_color.dart';
import 'package:eis_todo_app/view/todo_icon.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/add_edit_list_dialog.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/color_selector.dart';
import 'package:eis_todo_app/view/widgets/dialog_components/icon_selector.dart';
import 'package:eis_todo_app/view/widgets/listviews/todo_lists_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllListsPage extends StatelessWidget {
  const AllListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoListsNotifier = context.watch<TodoListCollectionNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Todo Lists'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: TodoListsView(todoListsNotifier: todoListsNotifier),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddOrEditListDialog(title: "New List").show(context),
        tooltip: 'Add List',
        child: const Icon(Icons.add),
      ),
    );
  }


}
