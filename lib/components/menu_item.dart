import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_pos/routes/route_paths.dart';

class MenuWidget extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void handleMenuItemSelected(BuildContext context, String value) {
    if (value == 'perfil') {
      // Ação para o menu "Perfil"
      Navigator.pushNamed(
        context,
        RoutePaths.PROFILE,
      ); // Redirecionar para a tela de perfil
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
