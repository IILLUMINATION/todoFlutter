import 'package:flutter/material.dart';
import 'package:todo_flutter/models/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;

  const TodoWidget({super.key, required this.todo, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        todo.title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
