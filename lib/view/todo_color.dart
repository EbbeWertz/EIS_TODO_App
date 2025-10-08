import 'package:flutter/material.dart';

class TodoColor{
  final int id;
  static int get maxId {
    return _materialColors.length - 1;
  }
  static final _materialColors = [
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
  TodoColor.fromColorId(this.id);
  MaterialColor get materialColor{
    return _materialColors[id];
  }

  @override
  bool operator ==(Object other) => other is TodoColor && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

