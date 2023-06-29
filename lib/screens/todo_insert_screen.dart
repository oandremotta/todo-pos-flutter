import 'package:flutter/material.dart';
import '../components/form_todo_item.dart';

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
