import 'package:eis_todo_app/model/data_models/todo.dart';
import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoAddOrEditSheet {
  final TodoListNotifier todoListNotifier;
  final Todo? todo; // null = add mode, non-null = edit mode

  TodoAddOrEditSheet(this.todoListNotifier, [this.todo]);

  void show(BuildContext context) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descController = TextEditingController(text: todo?.description ?? '');
    DateTime? selectedDate = todo?.deadline;

    if(todo != null){
      titleController.addListener(() {
        _saveTodo(context, titleController, descController, selectedDate, false);
      });
      descController.addListener(() {
        _saveTodo(context, titleController, descController, selectedDate, false);
      });
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        hintText: 'What do you need to do?',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) =>
                          _saveTodo(context, titleController, descController, selectedDate, true),
                    ),
                    // Description
                    TextField(
                      controller: descController,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Add a short description (optional)',
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Deadline pill
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () async {
                          final pickedOption = await showMenu<String>(
                            context: context,
                            position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                            items: const [
                              PopupMenuItem(value: 'None', child: Text('None')),
                              PopupMenuItem(value: 'Today', child: Text('Today')),
                              PopupMenuItem(value: 'Tomorrow', child: Text('Tomorrow')),
                              PopupMenuItem(value: 'Pick', child: Text('Pick Date')),
                            ],
                          );

                          if (pickedOption == null) return;

                          if (pickedOption == 'Pick') {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() => selectedDate = pickedDate);
                            }
                          } else if (pickedOption == 'None') {
                            setState(() => selectedDate = null);
                          } else if (pickedOption == 'Today') {
                            setState(() => selectedDate = DateTime.now());
                          } else if (pickedOption == 'Tomorrow') {
                            setState(() => selectedDate = DateTime.now().add(const Duration(days: 1)));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selectedDate == null
                                ? Colors.grey[300]
                                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: selectedDate == null
                                    ? Colors.grey[600]
                                    : Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                selectedDate == null
                                    ? 'No deadline'
                                    : DateFormat('dd/MM').format(selectedDate!),
                                style: TextStyle(
                                  color: selectedDate == null
                                      ? Colors.grey[600]
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
                if (todo == null)
                Positioned(
                  bottom: 12,
                  right: 8,
                  child: FloatingActionButton.small(
                    onPressed: () => _saveTodo(context, titleController, descController, selectedDate, true),
                    tooltip: todo == null ? 'Add Todo' : 'Save Todo',
                    child: const Icon(Icons.check),
                  ),
                ),
                if (todo != null)
                  Positioned(
                    bottom: 12,
                    left: 8,
                    child: Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            todoListNotifier.removeTodo(todo!);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            todoListNotifier.toggleTodoStatus(todo!);
                            Navigator.pop(context);
                          },
                          icon: Icon(todo!.completed ? Icons.undo : Icons.check),
                          label: Text(todo!.completed ? 'Mark Undone' : 'Mark Done'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveTodo(BuildContext context, TextEditingController titleController,
      TextEditingController descController, DateTime? deadline, bool close) {
    final title = titleController.text.trim();
    final desc = descController.text.trim();

    if (title.isEmpty) return;

    if (todo == null) {
      // Add mode
      todoListNotifier.addTodo(title, desc.isNotEmpty ? desc : null, deadline);
    } else {
      // Edit mode
      todoListNotifier.updateTodo(todo!, title, desc.isNotEmpty ? desc : null, todo!.favourite, deadline);
    }
    if(close) {
      Navigator.pop(context);
    }
  }
}
