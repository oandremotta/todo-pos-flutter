class Todo {
  String? id;
  String description;
  bool status;
  String location;
  DateTime dateTime;

  Todo(
    this.description,
    this.status,
    this.location,
    this.dateTime,
  );

  Todo.withId(
    this.id,
    this.description,
    this.status,
    this.location,
    this.dateTime,
  );

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        status = json['status'],
        location = json['location'],
        dateTime = DateTime.parse(json['dateTime']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'status': status,
        'location': location,
        'dateTime': dateTime.toIso8601String(),
      };

  static List<Todo> listFromJson(Map<String, dynamic> json) {
    List<Todo> todos = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = {'id': key, ...value};
      todos.add(Todo.fromJson(item));
    });
    return todos;
  }
}
