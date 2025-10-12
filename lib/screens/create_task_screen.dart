import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_flutter/models/task.dart';
import 'package:uuid/uuid.dart';

class CreateTaskScreen extends StatelessWidget {
  final VoidCallback onTaskAdded;

  const CreateTaskScreen({super.key, required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Добавьте новую задачу",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 20),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: textFieldController,
                  decoration: InputDecoration(hintText: "Текст задачи"),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String text = textFieldController.text.trim();

                        if (text.isNotEmpty) {
                          final box = Hive.box<Task>("tasks");
                          final newId = const Uuid().v4();
                          box.put(newId, Task(false, text, newId));

                          textFieldController.clear();
                          Navigator.pop(context);
                          onTaskAdded();
                        }
                      },
                      child: Text("Готово"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Отмена",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
