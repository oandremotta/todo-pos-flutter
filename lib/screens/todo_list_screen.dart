import 'package:flutter/material.dart';
import '../components/todo_list.dart';
import '../routes/route_paths.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Tarefas!'),
        ),
      ),
      body: Column(children: [
        TodoList(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePaths.TODOINSERTSCREEN);
        },
      ),
    );
  }
}
