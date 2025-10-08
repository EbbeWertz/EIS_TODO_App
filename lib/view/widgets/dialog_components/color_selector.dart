import 'package:eis_todo_app/view/todo_color.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final TodoColor value;
  final ValueChanged<TodoColor> onChanged;

  static final _colors = [for (int id = 0; id < TodoColor.maxId; id++) TodoColor.fromColorId(id)];

  const ColorSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TodoColor>(
      value: value,
      items: [
        for (final color in _colors)
          DropdownMenuItem(
            value: color,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color.materialColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
            ),
          ),
      ],
      onChanged: (color) {
        if (color != null) onChanged(color);
      },
    );
  }
}
