import '../repositories/todo_firestore_repository.dart';
import 'package:todos_pk/todos_pk.dart';

class TodoFireStoreService {
  final TodoFirestoreRepository _repository = TodoFirestoreRepository();

  Future<List<Todo>> getAll() async {
    try {
      return await _repository.list();
    } catch (error) {
      throw Exception('Failed to fetch todos: $error');
    }
  }

  Future<Todo> showTodo(String todoId) async {
    try {
      return await _repository.showTodo(todoId);
    } catch (error) {
      throw Exception('Failed to fetch todo: $error');
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await _repository.insert(todo);
    } catch (error) {
      throw Exception('Failed to add todo: $error');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _repository.update(todo);
    } catch (error) {
      throw Exception('Failed to update todo: $error');
    }
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      await _repository.delete(todoId);
    } catch (error) {
      throw Exception('Failed to delete todo: $error');
    }
  }
}
