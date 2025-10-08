import 'package:eis_todo_app/model/notifiers/todo_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTodoSheet {
  final TodoListNotifier todoListNotifier;

  AddTodoSheet(this.todoListNotifier);

  void show(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    DateTime? selectedDate; // null = no deadline

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final viewInsets = MediaQuery.of(context).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.only(bottom: viewInsets, left: 16, right: 16, top: 16),
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
                          _addTodo(context, titleController, descController, selectedDate, todoListNotifier),
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
                          // Show menu options
                          final pickedOption = await showMenu<String>(
                            context: context,
                            position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                            items: [
                              const PopupMenuItem(value: 'None', child: Text('None')),
                              const PopupMenuItem(value: 'Today', child: Text('Today')),
                              const PopupMenuItem(value: 'Tomorrow', child: Text('Tomorrow')),
                              const PopupMenuItem(value: 'Pick', child: Text('Pick Date')),
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
                Positioned(
                  bottom: 12,
                  right: 8,
                  child: FloatingActionButton.small(
                    onPressed: () =>
                        _addTodo(context, titleController, descController, selectedDate, todoListNotifier),
                    tooltip: 'Add Todo',
                    child: const Icon(Icons.check),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _addTodo(BuildContext context, TextEditingController titleController,
      TextEditingController descController, DateTime? deadline, TodoListNotifier notifier) {
    final title = titleController.text.trim();
    final desc = descController.text.trim();
    if (title.isNotEmpty) {
      notifier.addTodo(title, desc.isNotEmpty ? desc : null, deadline);
      Navigator.pop(context);
    }
  }
}
