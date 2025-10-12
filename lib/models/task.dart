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
  @HiveField(3)
  int priority;

  Task({
    required this.done,
    required this.text,
    required this.id,
    required this.priority,
  });
}
