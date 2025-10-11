import 'package:hive/hive.dart';

part "task.g.dart";

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String text;
  @HiveField(1)
  bool done;
  @HiveField(2)
  final String id;

  Task(this.done, this.text, this.id);
}
