import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/routes/route_paths.dart';
import 'package:flutter_todo_pos/providers/todo.provider.dart';
import 'screens/todo_insert_screen.dart';
import 'screens/todo_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TodoProvider(), // Fornecer a instância do TodoProvider
      child: MaterialApp(
        routes: {
          RoutePaths.HOME: (context) => TodoListScreen(),
          RoutePaths.TODOINSERTSCREEN: (context) => TodoInsertScreen(),
        },
      ),
    );
  }
}
