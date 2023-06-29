import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Todo {
  String? id;
  String description;
  bool status;
  String location;
  DateTime dateTime;
  String userId;

  Todo({
    this.id,
    required this.description,
    required this.status,
    required this.location,
    required this.dateTime,
    required this.userId,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        status = json['status'],
        location = json['location'],
        dateTime = DateTime.parse(json['dateTime']),
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'status': status,
        'location': location,
        'dateTime': dateTime.toIso8601String(),
        'userId': userId,
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
