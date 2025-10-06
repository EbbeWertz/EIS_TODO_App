import 'package:flutter/material.dart';

class Todo {
  final String id;
  String title;
  String? description;
  bool completed;

  Todo({required this.title, this.description, this.completed = false}): id = UniqueKey().toString();

  void toggleCompleted(){
    completed = !completed;
  }

  @override
  bool operator ==(Object other) => other is Todo && other.id == id;

  @override
  int get hashCode => id.hashCode;
}