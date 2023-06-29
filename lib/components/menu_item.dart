import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_pos/routes/route_paths.dart';

class MenuWidget extends StatelessWidget {
  final void Function(String) onMenuItemSelected;
  final FirebaseAuth auth = FirebaseAuth.instance;

  MenuWidget({
    required this.onMenuItemSelected,
    Key? key,
  }) : super(key: key);

  void handleMenuItemSelected(BuildContext context, String value) {
    if (value == 'perfil') {
      // Ação para o menu "Perfil"
      Navigator.pushNamed(
        context,
        RoutePaths.PROFILE,
      ); // Redirecionar para a tela de login
    } else if (value == 'sair') {
      auth.signOut(); // Fazer logout
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutePaths.LOGIN,
        (route) => false,
      ); // Redirecionar para a tela de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'perfil',
          child: Text('Perfil'),
        ),
        const PopupMenuItem(
          value: 'sair',
          child: Text('Sair'),
        ),
      ],
      onSelected: (value) => handleMenuItemSelected(context, value),
    );
  }
}
