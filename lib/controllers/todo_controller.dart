import 'package:signals/signals_flutter.dart';
import 'package:todo_flutter/models/todo.dart';
import 'package:uuid/uuid.dart';

final todoController = TodoController();

class TodoController {
  final _tasks = listSignal<Todo>([]);
  //объявляем пустой контроллер на основе класса туду

  ReadonlySignal<List<Todo>> get tasks => _tasks;
  //это типо чтобы геттер был публичным то есть можно только брать, а записывать нельзя

  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    final newTodo = Todo(id: Uuid().v4(), title: title, isDone: false);

    _tasks.add(newTodo);
  }
  //добавление задачи

  //удаление задачи
  void removeTodo(String id) {
    //копируем в отдельный локал лист т.к нельзя работать с реактивностью
    List<Todo> allTasks = _tasks.value;
    List<Todo> safeTasks = [];

    for (int i = 0; i < allTasks.length; i++) {
      Todo task = allTasks[i];

      if (task.id != id) {
        safeTasks.add(task);
      }
    }

    _tasks.value = safeTasks;
  }

  //изменение статуса задачи
  void changeStatus(String id) {
    List<Todo> allTasks = _tasks.value;
    List<Todo> safeTasks = [];

    for (int i = 0; i < allTasks.length; i++) {
      Todo task = allTasks[i];

      if (task.id == id) {
        Todo newTask =
            Todo(id: task.id, title: task.title, isDone: !task.isDone);
        safeTasks.add(newTask);
      } else {
        safeTasks.add(task);
      }
    }
    _tasks.value = safeTasks;
  }
}
