import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:todo_flutter/models/task.dart';
import 'package:todo_flutter/providers/tasks_provider.dart';
import 'package:todo_flutter/screens/create_task_screen.dart';

class NoneTasks extends StatelessWidget {
  const NoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Нету задач, чтобы добавить задачу, нажмите на кнопку +",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    List<Widget> _buildTasks() {
      List<Widget> widgets = [];

      if (tasks.length > 0) {
        for (int i = 0; i < tasks.length; i++) {
          TextDecoration? decoration;
          if (tasks[i].done) {
            decoration = TextDecoration.lineThrough;
          }
          widgets.add(
            Row(
              key: ValueKey(tasks[i].id),
              children: [
                Icon(Icons.note),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tasks[i].text,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      decoration: decoration,
                      decorationColor: Colors.red,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Checkbox(
                  value: tasks[i].done,
                  onChanged: (bool? value) {
                    final box = Hive.box<Task>("tasks");

                    tasks[i].done = value ?? false;
                    box.put(tasks[i].id, tasks[i]);
                    ref.invalidate(tasksProvider);
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    final box = Hive.box<Task>("tasks");
                    box.delete(tasks[i].id);
                    ref.invalidate(tasksProvider);
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                ),
              ],
            ),
          );
          widgets.add(SizedBox(height: 30));
        }
        return widgets;
      } else {
        return [Text("Отсутствуют задачи")];
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Мои задачи",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              if (tasks.isEmpty)
                NoneTasks()
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [..._buildTasks()]),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
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
      ),
    );
  }
}
