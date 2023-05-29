class Todo {
  String? id;
  String description;
  bool status;
  String location;

  Todo(this.description, this.status, this.location);
  Todo.withId(this.id, this.description, this.status, this.location);

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        status = json['status'],
        location = json['location'];

  // productA.toJson()
  Map<String, dynamic> toJson() =>
      {'description': description, 'status': status, 'location': location};

  static List<Todo> listFromJson(Map<String, dynamic> json) {
    List<Todo> todos = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = {"id": key, ...value};
      todos.add(Todo.fromJson(item));
    });
    return todos;
  }
}
