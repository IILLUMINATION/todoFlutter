import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:tutor/models/task.dart';
import 'package:tutor/providers/tasks_provider.dart';
import 'package:tutor/screens/create_task_screen.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    List<Widget> _buildTasks() {
      List<Widget> widgets = [];

      if (tasks.length > 0) {
        for (int i = 0; i < tasks.length; i++) {
          widgets.add(Text("Задача: ${tasks[i].text}"));
        }
        return widgets;
      } else {
        return [Text("Отсутствуют задачи")];
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Мои задачи"),
            ..._buildTasks(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                /*                 final box = Hive.box<Task>("tasks");
                box.add(Task(false, "Тестовая задача"));
                ref.invalidate(tasksProvider); */

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTaskScreen(
                      onTaskAdded: () {
                        ref.invalidate(tasksProvider);
                      },
                    ),
                  ),
                );
              },
              child: Text("Добавить задачу"),
            ),
          ],
        ),
      ),
    );
  }
}
