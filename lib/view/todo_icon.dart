import 'package:flutter/material.dart';

class TodoIcon{
  final int id;
  static int get maxId {
    return _materialIcons.length - 1;
  }
  static final _materialIcons = [
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
  TodoIcon.fromIconId(this.id);
  IconData get materialIconData{
    return _materialIcons[id];
  }

  @override
  bool operator ==(Object other) => other is TodoIcon && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

