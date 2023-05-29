import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/models/todo.dart';
import 'package:flutter_todo_pos/screens/todo_list_screen.dart';
import 'package:flutter_todo_pos/services/todos_service.dart';
import 'package:location/location.dart';

class FormTodoItem extends StatefulWidget {
  final String? paramId;
  final String? paramName;
  final String? paramLocation;
  final bool? paramStatus;

  const FormTodoItem({
    Key? key,
    this.paramId,
    this.paramName,
    this.paramLocation,
    this.paramStatus,
  }) : super(key: key);

  @override
  State<FormTodoItem> createState() => _FormTodoItemState();
}

class _FormTodoItemState extends State<FormTodoItem> {
  final _description = TextEditingController();
  final _location = TextEditingController();
  final ValueNotifier<bool> _statusNotifier = ValueNotifier<bool>(false);
  final TodosService _service = TodosService();
  late Future<String> _locationFuture;
  late String id = '';

  @override
  void initState() {
    super.initState();
    id = widget.paramId ?? '';
    _description.text = widget.paramName ?? '';
    _location.text = widget.paramLocation ?? '';
    _statusNotifier.value = widget.paramStatus ?? false;
    _locationFuture = widget.paramLocation != null
        ? Future.value(widget.paramLocation!)
        : getLocation();
  }

  Future<String> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return '';
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return '';
    }

    locationData = await location.getLocation();
    return "${locationData.latitude} : ${locationData.longitude}";
  }

  void onSubmit() {
    Todo todo = Todo(
      _description.text,
      _statusNotifier.value,
      _location.text,
    );
    if (id != '') {
      _service.update(id, todo);
    } else {
      _service.insert(todo);
    }
    Navigator.pop(context); // Voltar à tela anterior

    Navigator.pushReplacement(
      // Substituir a tela atual
      context,
      MaterialPageRoute(
        builder: (context) => const TodoListScreen(),
      ),
    );
  }

  void onDelete() {
    _service.delete(id);
    Navigator.pop(context); // Voltar à tela anterior

    Navigator.pushReplacement(
      // Substituir a tela atual
      context,
      MaterialPageRoute(
        builder: (context) => const TodoListScreen(),
      ),
    );
  }

  Widget buildButtonDelete() {
    if (id != '') {
      return ElevatedButton(
        onPressed: onDelete,
        child: Text("Deletar"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Muda a cor do botão para vermelho
        ),
      );
    }
    return Container(); // Adicionei um contêiner vazio no caso de id ser nulo
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Descrição da tarefa",
              ),
              controller: _description,
            ),
            const SizedBox(height: 16.0),
            FutureBuilder<String>(
              future: _locationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erro ao obter localização');
                } else {
                  _location.text = snapshot.data ?? '';
                  return TextField(
                    decoration: const InputDecoration(
                      labelText: "Localização",
                    ),
                    controller: _location,
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Status"),
                ValueListenableBuilder<bool>(
                  valueListenable: _statusNotifier,
                  builder: (context, value, child) {
                    return Checkbox(
                      value: value,
                      onChanged: (newValue) {
                        _statusNotifier.value = newValue!;
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text("Salvar"),
                ),
                const SizedBox(width: 16.0),
                buildButtonDelete(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
