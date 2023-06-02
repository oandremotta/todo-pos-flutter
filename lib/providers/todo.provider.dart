import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/models/todo.dart';
import 'package:flutter_todo_pos/services/todos_service.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> todos = [];
  static final _service = TodosService();
  Future<List<Todo>> list() async {
    if (todos.isEmpty) {
      todos = await TodosService().list();
    }
    return todos;
  }

  Future<void> insert(Todo todo) async {
    todos.add(todo);
    await _service.insert(todo);
    notifyListeners();
  }

  Future<void> update(Todo todo) async {
    final index = todos.indexWhere((item) => item.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await _service.update(todo.id.toString(), todo);
      notifyListeners();
    }
  }

  Future<void> remove(Todo todo) async {
    todos.remove(todo);
    await _service.delete(todo.id.toString());
    notifyListeners();
  }
}
