import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_pos/models/todo.dart';

void main() {
  group('Todo Tests', () {
    test('Todo.fromJson should create a Todo object from JSON', () {
      // Arrange
      final json = {
        'id': '1',
        'description': 'Buy groceries',
        'status': true,
        'location': 'Supermarket',
        'dateTime': '2023-06-29T10:00:00Z',
      };

      // Act
      final todo = Todo.fromJson(json);

      // Assert
      expect(todo.id, '1');
      expect(todo.description, 'Buy groceries');
      expect(todo.status, true);
      expect(todo.location, 'Supermarket');
      expect(todo.dateTime, DateTime.utc(2023, 06, 29, 10, 0, 0));
    });
    test('Todo.toJson should convert a Todo object to JSON', () {
      // Arrange
      final todo = Todo.withId(
        '1',
        'Buy groceries',
        true,
        'Supermarket',
        DateTime.utc(2023, 6, 29, 10, 0, 0),
      );

      // Act
      final json = todo.toJson();

      // Assert
      expect(json['id'], '1');
      expect(json['description'], 'Buy groceries');
      expect(json['status'], true);
      expect(json['location'], 'Supermarket');
      expect(json['dateTime'], '2023-06-29T10:00:00.000Z');
    });

    test('Todo.listFromJson should create a list of Todo objects from JSON',
        () {
      // Arrange
      final json = {
        '1': {
          'description': 'Buy groceries',
          'status': true,
          'location': 'Supermarket',
          'dateTime': '2023-06-29T10:00:00Z',
        },
        '2': {
          'description': 'Walk the dog',
          'status': false,
          'location': 'Park',
          'dateTime': '2023-06-30T15:00:00Z',
        },
      };

      // Act
      final todos = Todo.listFromJson(json);

      // Assert
      expect(todos.length, 2);
      expect(todos[0].id, '1');
      expect(todos[0].description, 'Buy groceries');
      expect(todos[0].status, true);
      expect(todos[0].location, 'Supermarket');
      expect(todos[0].dateTime, DateTime.utc(2023, 06, 29, 10, 0, 0));
      expect(todos[1].id, '2');
      expect(todos[1].description, 'Walk the dog');
      expect(todos[1].status, false);
      expect(todos[1].location, 'Park');
      expect(todos[1].dateTime, DateTime.utc(2023, 06, 30, 15, 0, 0));
    });

    test('Todo.fromJson should create a Todo object from JSON', () {
      // Arrange
      final json = {
        'id': '1',
        'description': 'Buy groceries',
        'status': true,
        'location': 'Supermarket',
        'dateTime': '2023-06-29T10:00:00.000Z',
      };

      // Act
      final todo = Todo.fromJson(json);

      // Assert
      expect(todo.id, '1');
      expect(todo.description, 'Buy groceries');
      expect(todo.status, true);
      expect(todo.location, 'Supermarket');
      expect(todo.dateTime, DateTime.utc(2023, 6, 29, 10, 0, 0));
    });

    test('Todo.listFromJson should create a list of Todo objects from JSON',
        () {
      // Arrange
      final json = {
        '1': {
          'description': 'Buy groceries',
          'status': true,
          'location': 'Supermarket',
          'dateTime': '2023-06-29T10:00:00.000Z',
        },
        '2': {
          'description': 'Walk the dog',
          'status': false,
          'location': 'Park',
          'dateTime': '2023-06-30T15:30:00.000Z',
        },
      };

      // Act
      final todos = Todo.listFromJson(json);

      // Assert
      expect(todos.length, 2);

      expect(todos[0].id, '1');
      expect(todos[0].description, 'Buy groceries');
      expect(todos[0].status, true);
      expect(todos[0].location, 'Supermarket');
      expect(todos[0].dateTime, DateTime.utc(2023, 6, 29, 10, 0, 0));

      expect(todos[1].id, '2');
      expect(todos[1].description, 'Walk the dog');
      expect(todos[1].status, false);
      expect(todos[1].location, 'Park');
      expect(todos[1].dateTime, DateTime.utc(2023, 6, 30, 15, 30, 0));
    });
  });
}
