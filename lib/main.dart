import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/providers/todo_firestore_provider.dart';
import 'package:flutter_todo_pos/routes/route_paths.dart';
import 'package:flutter_todo_pos/screens/login_screen.dart';
import 'package:flutter_todo_pos/screens/profile_screen.dart';
import 'package:flutter_todo_pos/screens/todo_insert_screen.dart';
import 'package:flutter_todo_pos/screens/todo_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_pos/components/menu_item.dart';
import 'package:flutter_todo_pos/firebase_options.dart';
import 'package:todos_pk/todos_pk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoFireStoreProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutePaths.LOGIN,
        routes: {
          RoutePaths.LOGIN: (context) => Scaffold(
                body: LoginScreen(),
              ),
          RoutePaths.HOME: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('Tarefas!'),
                  actions: [
                    MenuWidget(),
                  ],
                ),
                body: TodoListScreen(),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RoutePaths.TODOINSERTSCREEN);
                  },
                ),
              ),
          RoutePaths.TODOINSERTSCREEN: (context) => Scaffold(
                body: TodoInsertScreen(),
              ),
          RoutePaths.PROFILE: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('Perfil'),
                  actions: [
                    MenuWidget(),
                  ],
                ),
                body: ProfileScreen(),
              ),
        },
      ),
    );
  }
}
