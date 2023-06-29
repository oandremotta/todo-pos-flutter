import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todos_pk/todos_pk.dart';
import '../providers/todo.provider.dart';
import '../providers/todo_firestore_provider.dart';
import '../screens/todo_insert_screen.dart';

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
          Provider.of<TodoFireStoreProvider>(context, listen: false)
              .remove(todo); // Utilizando o TodoProvider para remover a tarefa
          onDelete(); // Chamando a função onDelete após a exclusão
        },
      ),
      title: Text(todo.description),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task starts at: ${DateFormat('HH:mm:ss dd/MM/yyyy').format(todo.dateTime)}',
          ),
          Text('Location: ${todo.location}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: todo.status,
            onChanged: (value) {
              onTodoStatusChanged(value ?? false);
              Provider.of<TodoProvider>(context, listen: false).update(
                  todo); // Utilizando o TodoProvider para atualizar a tarefa
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
              paramDateTime: todo.dateTime,
            ),
          ),
        ),
      },
    );
  }
}
