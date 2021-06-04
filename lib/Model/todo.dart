class Todo {
  final int id;
  final String title;
  final int isDone;
  final int taskId;

  Todo({this.taskId, this.id, this.title, this.isDone});

  //Method to Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': 'taskId',
      'title': title,
      'isDone': isDone,
    };
  }
}
