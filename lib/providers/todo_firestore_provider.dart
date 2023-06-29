import 'package:flutter/material.dart';
import 'package:todos_pk/todos_pk.dart';
import '../services/todos_firestore_service.dart';

class TodoFireStoreProvider with ChangeNotifier {
  List<Todo> todos = [];
  static final _service = TodoFireStoreService();

  Future<List<Todo>> list() async {
    if (todos.isEmpty) {
      todos = await _service.getAll();
    }
    return todos;
  }

  Future<void> insert(Todo todo) async {
    await _service.addTodo(todo);
    todos.add(todo);
    notifyListeners();
  }

  Future<void> update(Todo todo) async {
    final index = todos.indexWhere((item) => item.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await _service.updateTodo(todo);
      notifyListeners();
    }
  }

  Future<void> remove(Todo todo) async {
    await _service.deleteTodo(todo.id.toString());
    todos.remove(todo);
    notifyListeners();
  }
}
