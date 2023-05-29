import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/routes/route_paths.dart';
import 'screens/todo_insert_screen.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RoutePaths.HOME: (context) => TodoListScreen(),
        RoutePaths.TODOINSERTSCREEN: (context) => TodoInsertScreen(),
      },
    );
  }
}
