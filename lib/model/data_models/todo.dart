class Todo {
  String id;
  String title;
  String? description;
  bool completed;
  int position;

  Todo({required this.id, required this.title, this.description, this.completed = false, required this.position});

  void toggleCompleted(){
    completed = !completed;
  }

  @override
  bool operator ==(Object other) => other is Todo && other.id == id;

  @override
  int get hashCode => id.hashCode;
}