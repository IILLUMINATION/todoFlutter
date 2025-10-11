import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutor/models/task.dart';

final tasksProvider = Provider<List<Task>>((ref) {
  final box = Hive.box<Task>("tasks");

  return box.values.toList();
});
