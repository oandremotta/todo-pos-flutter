import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_pos/screens/login_screen.dart';
import 'package:flutter_todo_pos/screens/register_screen.dart';

void main() {
  setUpAll(() async {
    // Inicializa o Firebase antes de executar os testes
    await Firebase.initializeApp();
  });

  testWidgets('LoginScreen should display email and password fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text('Registrar'), findsOneWidget);
  });

  testWidgets('LoginScreen should show snackbar after successful login',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    final emailField = find.byKey(ValueKey('emailField'));
    final passwordField = find.byKey(ValueKey('passwordField'));
    final loginButton = find.byKey(ValueKey('loginButton'));

    await tester.enterText(emailField, 'andre@gmail.com');
    await tester.enterText(passwordField, '123456');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Usuario logado'), findsOneWidget);
  });

  testWidgets('LoginScreen should navigate to RegisterScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    final registerButton = find.byKey(ValueKey('registerButton'));

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
  });
}
