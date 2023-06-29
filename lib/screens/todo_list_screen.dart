import 'package:flutter/material.dart';
import '../components/menu_item.dart';
import '../components/todo_list.dart';
import '../routes/route_paths.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: const Column(
        children: [
          TodoList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePaths.TODOINSERTSCREEN);
        },
      ),
    );
  }
}
