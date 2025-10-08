class Todo {
  String id;
  String title;
  String? description;
  bool completed;
  int position;
  bool favourite;
  DateTime? deadline;

  Todo({required this.id, required this.title, this.description, this.completed = false, required this.position, this.favourite = false, this.deadline});

  void toggleCompleted(){
    completed = !completed;
  }

  @override
  bool operator ==(Object other) => other is Todo && other.id == id;

  @override
  int get hashCode => id.hashCode;
}