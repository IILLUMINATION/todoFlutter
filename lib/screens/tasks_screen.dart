import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/models/task.dart';
import 'package:todo_flutter/providers/tasks_provider.dart';
import 'package:todo_flutter/screens/create_task_screen.dart';
import 'package:todo_flutter/utils/helpers.dart';

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

  List<Widget> _buildTasks(List<Task> tasks, WidgetRef ref) {
    List<Widget> widgets = [];
    final sortedTasks = [...tasks]
      ..sort((a, b) => b.priority.compareTo(a.priority));

    for (var task in sortedTasks) {
      final decoration = task.done ? TextDecoration.lineThrough : null;

      widgets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  key: ValueKey(task.id),
                  children: [
                    Icon(Icons.note),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        task.text,
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
                      value: task.done,
                      onChanged: (bool? value) {
                        ref.read(tasksProvider.notifier).toggleDone(task);
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        ref.read(tasksProvider.notifier).deleteTask(task.id);
                      },
                      icon: Icon(Icons.delete, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Приоритет: ${checkerPriority(task.priority)}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      widgets.add(SizedBox(height: 30));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTasks = ref.watch(tasksProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: asyncTasks.when(
            data: (tasks) {
              return Column(
                children: [
                  Text(
                    "Мои задачи",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  if (tasks.isEmpty)
                    NoneTasks()
                  else
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: _buildTasks(tasks, ref)),
                      ),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTaskScreen(),
                        ),
                      );
                    },
                    child: Text("Добавить задачу"),
                  ),
                ],
              );
            },
            loading: () => CircularProgressIndicator(color: Colors.white),
            error:
                (err, stack) =>
                    Text("Ошибка: $err", style: TextStyle(color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
