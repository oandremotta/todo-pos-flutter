import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/screens/todo_insert_screen.dart';
import 'package:flutter_todo_pos/services/todos_service.dart';
import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onTodoStatusChanged,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(bool) onTodoStatusChanged;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          TodosService().delete(todo.id.toString());
          onDelete(); // Chamando a função onDelete após a exclusão
        },
      ),
      title: Text(todo.description),
      subtitle: Text(todo.location),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: todo.status,
            onChanged: (value) {
              onTodoStatusChanged(value ?? false);
              TodosService().update(todo.id.toString(), todo);
            },
          ),
        ],
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoInsertScreen(
              paramId: todo.id.toString(),
              paramName: todo.description,
              paramLocation: todo.location,
              paramStatus: todo.status,
            ),
          ),
        ),
      },
    );
  }
}
