import 'package:eis_todo_app/view/todo_icon.dart';
import 'package:flutter/material.dart';

class IconSelector extends StatelessWidget {
  final TodoIcon value;
  final ValueChanged<TodoIcon> onChanged;

  static final _icons = [for (int id = 0; id < TodoIcon.maxId; id++) TodoIcon.fromIconId(id)];


  const IconSelector({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TodoIcon>(
      value: value,
      items: [
        for (final icon in _icons)
          DropdownMenuItem(value: icon, child: Icon(icon.materialIconData)),
      ],
      onChanged: (icon) {
        if (icon != null) onChanged(icon);
      },
    );
  }
}
