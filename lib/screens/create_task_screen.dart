import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_flutter/models/task.dart';

class CreateTaskScreen extends StatelessWidget {
  final VoidCallback onTaskAdded;

  const CreateTaskScreen({super.key, required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Добавьте новую задачу"),
            TextField(
              controller: textFieldController,
              decoration: InputDecoration(hintText: "Текст задачи"),
            ),
            ElevatedButton(
              onPressed: () {
                String text = textFieldController.text.trim();

                if (text.isNotEmpty) {
                  final box = Hive.box<Task>("tasks");
                  box.add(Task(false, text));

                  textFieldController.clear();
                  Navigator.pop(context);
                  onTaskAdded();
                }
              },
              child: Text("Готово"),
            ),
          ],
        ),
      ),
    );
  }
}
