import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/components/todo_list_item.dart';
import 'package:flutter_todo_pos/services/todos_service.dart';
import '../models/todo.dart';
import '../providers/todo_firestore_provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    todos = await TodoFireStoreProvider().list();
    setState(() {});
  }

  Future<void> deleteTask(String taskId) async {
    await TodosService().delete(taskId);
    await fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return todos.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoListItem(
                  todo: todos[index],
                  onTodoStatusChanged: (value) {
                    todos[index].status = value;
                    setState(() {});
                  },
                  onDelete: () => deleteTask(
                    todos[index].id.toString(),
                  ),
                );
              },
            ),
          )
        : const Center(child: Text("Não há tarefas cadastradas"));
  }
}
