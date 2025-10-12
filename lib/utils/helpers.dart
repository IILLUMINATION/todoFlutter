import 'package:hive/hive.dart';
import 'package:todo_flutter/models/task.dart';

String checkerPriority(int valueSlider) {
  String text = "";
  if (valueSlider == 0) {
    text = "Низкий";
  } else if (valueSlider == 1) {
    text = "Средний";
  } else if (valueSlider == 2) {
    text = "Высокий";
  }
  return text;
}

void deleteTask(int id) {
  final box = Hive.box<Task>("tasks");
  box.delete(id);
}
