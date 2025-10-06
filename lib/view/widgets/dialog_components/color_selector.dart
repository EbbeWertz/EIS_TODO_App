import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final Color value;
  final ValueChanged<Color> onChanged;

  static final colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lime,
    Colors.yellow,
  ];

  const ColorSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Color>(
      value: value,
      items: [
        for (final color in colors)
          DropdownMenuItem(
            value: color,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
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
