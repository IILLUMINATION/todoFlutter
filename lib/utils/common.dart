import 'package:todo_flutter/controllers/todo_controller.dart';

addTask(String text) {
  print(text);
  todoController.addTodo(text);

  return true;
}
