import 'package:flutter/material.dart';
import '../components/form_todo_item.dart';
import '../components/menu_item.dart';

class TodoInsertScreen extends StatelessWidget {
  final String? paramId;
  final String? paramName;
  final String? paramLocation;
  final bool? paramStatus;
  final DateTime? paramDateTime;

  const TodoInsertScreen({
    this.paramId,
    this.paramName,
    this.paramLocation,
    this.paramStatus,
    this.paramDateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Tarefas!'),
        ),
        actions: [
          MenuWidget(),
        ],
      ),
      body: Column(
        children: [
          FormTodoItem(
            paramId: paramId,
            paramName: paramName,
            paramLocation: paramLocation,
            paramStatus: paramStatus,
          ),
        ],
      ),
    );
  }
}
