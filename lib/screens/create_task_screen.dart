import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_flutter/models/task.dart';
import 'package:todo_flutter/providers/tasks_provider.dart';
import 'package:todo_flutter/utils/helpers.dart';
import 'package:uuid/uuid.dart';

final createTaskPriorityProvider = StateProvider<int>((ref) => 0);

class CreateTaskScreen extends ConsumerWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textFieldController = TextEditingController();
    final priority = ref.watch(createTaskPriorityProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(30),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Выберите приоритет задачи:",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Slider(
                value: priority.toDouble(),
                min: 0,
                max: 2,
                divisions: 2,
                onChanged: (newValue) {
                  ref.read(createTaskPriorityProvider.notifier).state =
                      newValue.toInt();
                },
              ),
              Text(
                checkerPriority(ref.read(createTaskPriorityProvider)),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String text = textFieldController.text.trim();

                      if (text.isNotEmpty) {
                        ref
                            .read(tasksProvider.notifier)
                            .createTask(text, priority);
                        textFieldController.clear();
                        Navigator.pop(context);
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
    );
  }
}
