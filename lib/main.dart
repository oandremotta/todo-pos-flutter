import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/providers/todo.provider.dart';
import 'package:flutter_todo_pos/routes/route_paths.dart';
import 'package:flutter_todo_pos/screens/login_screen.dart';
import 'package:flutter_todo_pos/screens/profile_screen.dart';
import 'package:flutter_todo_pos/screens/todo_insert_screen.dart';
import 'package:flutter_todo_pos/screens/todo_list_screen.dart';
import 'package:provider/provider.dart';
import 'components/menu_item.dart';
import 'firebase_options.dart';

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
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutePaths.LOGIN,
        routes: {
          RoutePaths.LOGIN: (context) => Scaffold(
                body: LoginScreen(),
              ),
          RoutePaths.HOME: (context) => Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text('Tarefas!'),
                  actions: [
                    MenuWidget(
                      onMenuItemSelected: (value) =>
                          handleMenuItemSelected(context, value),
                    ),
                  ],
                ),
                body: TodoListScreen(),
              ),
          RoutePaths.TODOINSERTSCREEN: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('Inserir Tarefa'),
                  actions: [
                    MenuWidget(
                      onMenuItemSelected: (value) =>
                          handleMenuItemSelected(context, value),
                    ),
                  ],
                ),
                body: TodoInsertScreen(),
              ),
          RoutePaths.PROFILE: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('Perfil'),
                  actions: [
                    MenuWidget(
                      onMenuItemSelected: (value) =>
                          handleMenuItemSelected(context, value),
                    ),
                  ],
                ),
                body: ProfileScreen(),
              ),
        },
      ),
    );
  }

  void handleMenuItemSelected(BuildContext context, String value) {
    if (value == 'perfil') {
      // Ação para o menu "Perfil"
      Navigator.pushNamed(
        context,
        RoutePaths.PROFILE,
      ); // Redirecionar para a tela de login
    } else if (value == 'sair') {
      FirebaseAuth.instance.signOut(); // Fazer logout
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutePaths.LOGIN,
        (route) => false,
      ); // Redirecionar para a tela de login
    }
  }
}
