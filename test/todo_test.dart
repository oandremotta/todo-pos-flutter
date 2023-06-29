import 'package:flutter_test/flutter_test.dart';
import 'package:todos_pk/todos_pk.dart';

void main() {
  group('Todo', () {
    test('fromJson() should parse JSON correctly', () {
      // Dado um mapa JSON válido
      Map<String, dynamic> json = {
        'id': '1',
        'description': 'Complete assignment',
        'status': true,
        'location': 'Home',
        'dateTime': '2023-06-29T10:00:00Z',
        'userId': '123'
      };

      // Quando chamar o método fromJson()
      Todo todo = Todo.fromJson(json);

      // Então os atributos devem ser definidos corretamente
      expect(todo.id, '1');
      expect(todo.description, 'Complete assignment');
      expect(todo.status, true);
      expect(todo.location, 'Home');
      expect(todo.dateTime,
          DateTime.utc(2023, 06, 29, 10, 00, 00).toUtc()); // Corrigido
      expect(todo.userId, '123');
    });

    test('toJson() should convert to JSON correctly', () {
      // Dado um objeto Todo válido
      Todo todo = Todo(
        description: 'Complete assignment',
        status: true,
        location: 'Home',
        dateTime: DateTime.utc(2023, 06, 29, 10, 00, 00),
        userId: '123',
      );

      // Quando chamar o método toJson()
      Map<String, dynamic> json = todo.toJson();

      // Então o mapa JSON resultante deve conter os valores corretos
      expect(json['description'], 'Complete assignment');
      expect(json['status'], true);
      expect(json['location'], 'Home');
      expect(json['dateTime'],
          DateTime.utc(2023, 06, 29, 10, 00, 00).toUtc().toIso8601String());
      expect(json['userId'], '123');
    });

    test('listFromJson() should parse a JSON map to a list of Todo objects',
        () {
      // Dado um mapa JSON com múltiplos objetos Todo
      Map<String, dynamic> json = {
        'todo1': {
          'description': 'Complete assignment',
          'status': true,
          'location': 'Home',
          'dateTime': '2023-06-29T10:00:00Z',
          'userId': '123'
        },
        'todo2': {
          'description': 'Buy groceries',
          'status': false,
          'location': 'Supermarket',
          'dateTime': '2023-06-30T15:30:00Z',
          'userId': '456'
        }
      };

      // Quando chamar o método listFromJson()
      List<Todo> todos = Todo.listFromJson(json);

      // Então a lista resultante deve conter os objetos Todo corretos
      expect(todos.length, 2);

      // Verificando o primeiro objeto Todo
      expect(todos[0].id, 'todo1');
      expect(todos[0].description, 'Complete assignment');
      expect(todos[0].status, true);
      expect(todos[0].location, 'Home');
      expect(todos[0].dateTime,
          DateTime.utc(2023, 06, 29, 10, 00, 00).toUtc()); // Corrigido
      expect(todos[0].userId, '123');

      // Verificando o segundo objeto Todo
      expect(todos[1].id, 'todo2');
      expect(todos[1].description, 'Buy groceries');
      expect(todos[1].status, false);
      expect(todos[1].location, 'Supermarket');
      expect(todos[1].dateTime,
          DateTime.utc(2023, 06, 30, 15, 30, 00).toUtc()); // Corrigido
      expect(todos[1].userId, '456');
    });
  });
}
