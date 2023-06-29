import 'package:flutter/material.dart';
import '../components/menu_item.dart';
import '../components/todo_list.dart';
import '../routes/route_paths.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  void handleMenuItemSelected(String value) {
    if (value == 'perfil') {
      // Ação para o menu "Perfil"
      // Implemente a lógica desejada
    } else if (value == 'sair') {
      // Ação para o menu "Sair"
      // Implemente a lógica desejada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Tarefas!'),
        ),
        actions: [
          MenuWidget(onMenuItemSelected: handleMenuItemSelected),
        ],
      ),
      body: Column(children: [
        TodoList(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePaths.TODOINSERTSCREEN);
        },
      ),
    );
  }
}
