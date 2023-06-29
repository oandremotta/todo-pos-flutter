import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/models/todo.dart';

class TodoShowScreen extends StatelessWidget {
  const TodoShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var arg =
    Todo todo = ModalRoute.of(context)?.settings.arguments as Todo;

    return Scaffold(
      body: Column(
        children: [
          Text(
            todo.status.toString(),
            style: const TextStyle(fontSize: 30.0),
          ),
          Text(
            todo.location,
            style: const TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }
}
