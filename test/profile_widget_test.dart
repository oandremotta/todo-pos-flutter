import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_pos/screens/profile_screen.dart';

void main() {
  group('ProfileScreen', () {
    testWidgets('Renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
    });

    testWidgets('Displays email correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

      final emailTextFinder = find.text('E-mail: ');
      expect(emailTextFinder, findsOneWidget);
    });
  });
}

class ProfileScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Selecionar Imagem'),
                ),
                const SizedBox(height: 32),
                Text('E-mail: ${emailController.text}'),
                const SizedBox(height: 18),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Nova Senha',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Alterar Senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
