import 'dart:convert';
import 'package:http/http.dart';
import '../models/todo.dart';
import '../repositories/todos_repository.dart';

class TodosService {
  final TodosRepository _todosRepository = TodosRepository();

  Future<List<Todo>> list() async {
    try {
      Response response = await _todosRepository.list();
      Map<String, dynamic> json = jsonDecode(response.body);
      return Todo.listFromJson(json);
    } catch (err) {
      throw Exception("Problemas ao consultar lista de tarefas.");
    }
  }

  Future<String> insert(Todo todo) async {
    try {
      String json = jsonEncode(todo.toJson());
      Response response = await _todosRepository.insert(json);
      return jsonDecode(response.body).toString();
    } catch (err) {
      throw Exception("Problemas ao inserir a tarefa: ${err.toString()}");
    }
  }

  Future<Map<String, dynamic>> update(String id, Todo todo) async {
    try {
      String json = jsonEncode(todo.toJson());
      Response response = await _todosRepository.update(id, json);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (err) {
      throw Exception("Problemas ao atualizar a tarefa: ${err.toString()}");
    }
  }

  Future<bool> delete(String id) async {
    try {
      Response response = await _todosRepository.delete(id);
      return response.statusCode == 200;
    } catch (err) {
      throw Exception("Problemas ao excluir a tarefa.");
    }
  }
}
