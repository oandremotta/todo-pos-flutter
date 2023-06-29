import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_pk/todos_pk.dart';

class TodoFirestoreRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionPath = 'tarefas';
  final auth = FirebaseAuth.instance;

  Future<List<Todo>> list() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final querySnapshot = await _db
        .collection(collectionPath)
        .doc(userId)
        .collection('userTasks')
        .get();
    final todoList =
        querySnapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList();
    return todoList;
  }

  Future<Todo> showTodo(String todoId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docSnapshot = await _db
        .collection(collectionPath)
        .doc(userId)
        .collection('userTasks')
        .doc(todoId)
        .get();

    return docSnapshot.exists
        ? Todo.fromJson(docSnapshot.data()!)
        : Todo(
            id: '',
            description: '',
            status: false,
            location: '',
            dateTime: DateTime.now(),
            userId: userId ?? '',
          );
  }

  Future<void> insert(Todo todo) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef = _db
        .collection(collectionPath)
        .doc(userId)
        .collection('userTasks')
        .doc();
    todo.id = docRef.id;
    await docRef.set(todo.toJson());
  }

  Future<void> update(Todo todo) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef = _db
        .collection(collectionPath)
        .doc(userId)
        .collection('userTasks')
        .doc(todo.id);
    await docRef.update(todo.toJson());
  }

  Future<void> delete(String todoId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final docRef = _db
        .collection(collectionPath)
        .doc(userId)
        .collection('userTasks')
        .doc(todoId);
    await docRef.delete();
  }
}
