import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:todo_flutter/controllers/todo_controller.dart';
import 'package:todo_flutter/models/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;

  const TodoWidget({super.key, required this.todo, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.blueGrey,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12)),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Checkbox(
                  value: todo.isDone,
                  onChanged: (newValue) {
                    todoController.changeStatus(todo.id);
                  }),
              Expanded(
                  child: Text(
                todo.title,
                style: TextStyle(color: Colors.white),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
