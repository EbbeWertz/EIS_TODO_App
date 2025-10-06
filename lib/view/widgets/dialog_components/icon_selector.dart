import 'package:flutter/material.dart';

class IconSelector extends StatelessWidget {
  final IconData value;
  final ValueChanged<IconData> onChanged;

  static final icons = [
    Icons.list,
    Icons.work,
    Icons.shopping_cart,
    Icons.school,
    Icons.home,
    Icons.fitness_center,
    Icons.book,
    Icons.restaurant,
    Icons.flight,
    Icons.movie,
    Icons.music_note,
    Icons.pets,
  ];

  const IconSelector({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<IconData>(
      value: value,
      items: [
        for (final icon in icons)
          DropdownMenuItem(value: icon, child: Icon(icon)),
      ],
      onChanged: (icon) {
        if (icon != null) onChanged(icon);
      },
    );
  }
}
