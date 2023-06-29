import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_pos/models/todo.dart';
import 'package:flutter_todo_pos/providers/todo_firestore_provider.dart';
import 'package:flutter_todo_pos/screens/todo_list_screen.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class FormTodoItem extends StatefulWidget {
  final String? paramId;
  final String? paramName;
  final String? paramLocation;
  final bool? paramStatus;
  final DateTime? paramDateTime;

  const FormTodoItem({
    Key? key,
    this.paramId,
    this.paramName,
    this.paramLocation,
    this.paramStatus,
    this.paramDateTime,
  }) : super(key: key);

  @override
  State<FormTodoItem> createState() => _FormTodoItemState();
}

class _FormTodoItemState extends State<FormTodoItem> {
  final _description = TextEditingController();
  final _location = TextEditingController();
  final ValueNotifier<bool> _statusNotifier = ValueNotifier<bool>(false);
  late Future<String> _locationFuture;
  late String id = '';
  late DateTime _dateTime; // New field for date and time

  @override
  void initState() {
    super.initState();
    id = widget.paramId ?? '';
    _description.text = widget.paramName ?? '';
    _location.text = widget.paramLocation ?? '';
    _statusNotifier.value = widget.paramStatus ?? false;
    _dateTime = DateTime.now(); // Initialize with current date and time
    _locationFuture = widget.paramLocation != null
        ? Future.value(widget.paramLocation!)
        : getLocation();
    _dateTime = widget.paramDateTime ?? DateTime.now();
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

  void onSubmit() async {
    final todoProvider =
        Provider.of<TodoFireStoreProvider>(context, listen: false);

    Todo todo = Todo(
      id: id,
      description: _description.text,
      status: _statusNotifier.value,
      location: _location.text,
      dateTime: _dateTime, // Include the date and time field
      userId: FirebaseAuth.instance.currentUser?.uid ?? '',
    );

    if (id != '') {
      await todoProvider.update(todo);
    } else {
      await todoProvider.insert(todo);
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

  void onDelete() async {
    final todoProvider =
        Provider.of<TodoFireStoreProvider>(context, listen: false);
    Todo todo = Todo(
      id: id,
      description: _description.text,
      status: _statusNotifier.value,
      location: _location.text,
      dateTime: _dateTime,
      userId: FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    await todoProvider.remove(todo);

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
        child: Text("Delete"),
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
                labelText: "Task Description",
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
                  return const Text('Error fetching location');
                } else {
                  _location.text = snapshot.data ?? '';
                  return TextField(
                    decoration: const InputDecoration(
                      labelText: "Location",
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
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _dateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_dateTime),
                      );

                      if (time != null) {
                        setState(() {
                          _dateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                  child: const Text('Select Date and Time'),
                ),
                const SizedBox(width: 16.0),
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
                  child: const Text("Save"),
                ),
                const SizedBox(width: 16.0),
                buildButtonDelete(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
