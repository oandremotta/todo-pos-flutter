import 'package:flutter/material.dart';
import 'package:todos_pk/todos_pk.dart';

import '../components/menu_item.dart';

class TodoShowScreen extends StatelessWidget {
  const TodoShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var arg =
    Todo todo = ModalRoute.of(context)?.settings.arguments as Todo;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Tarefas!'),
        ),
        actions: [
          MenuWidget(),
        ],
      ),
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
