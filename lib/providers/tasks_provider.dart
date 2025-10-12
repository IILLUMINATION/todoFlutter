import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_flutter/models/task.dart';
import 'package:uuid/uuid.dart';

final tasksProvider = AsyncNotifierProvider<TasksNotifier, List<Task>>(
  TasksNotifier.new,
);

class TasksNotifier extends AsyncNotifier<List<Task>> {
  @override
  List<Task> build() {
    final box = Hive.box<Task>("tasks");
    return box.values.toList();
  }

  void createTask(String text, int priority) {
    final box = Hive.box<Task>("tasks");
    final id = const Uuid().v4();
    final task = Task(id: id, done: false, text: text, priority: priority);
    box.put(id, task);
    state = AsyncData(box.values.toList());
  }

  void deleteTask(String id) {
    final box = Hive.box<Task>("tasks");
    box.delete(id);
    state = AsyncData(box.values.toList());
  }

  void toggleDone(Task task) {
    final box = Hive.box<Task>("tasks");
    task.done = !task.done;
    box.put(task.id, task);
    state = AsyncData(box.values.toList());
  }
}
