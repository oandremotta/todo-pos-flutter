import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  File? _image;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final firebaseStorage = FirebaseStorage.instance;
    final fileName = '$userId.jpg';
    final reference = firebaseStorage.ref("profiles/$fileName");
    final imageUrl = await reference.getDownloadURL();
    setState(() {
      this.imageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final email = user?.email;

    return Scaffold(
      body: SingleChildScrollView(
        // Adicionando SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 80,
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Selecionar Imagem'),
              ),
              const SizedBox(height: 32),
              Text('E-mail: $email'),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Nova Senha',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _changePassword,
                child: const Text('Alterar Senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      final firebaseStorage = FirebaseStorage.instance;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final fileName = '$userId.jpg';
      print(fileName);
      final reference = firebaseStorage.ref("profiles/$fileName");
      await reference.putFile(_image!);
      fetchProfileImage(); // Atualizar a imagem após o upload
    }
  }

  Future<void> _changePassword() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(_passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha alterada com sucesso!'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocorreu um erro ao alterar a senha.'),
          ),
        );
      }
    }
  }
}
