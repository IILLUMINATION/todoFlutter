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
              )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.brown,
                            title: Text("Удалить тудушку?",
                                style: TextStyle(color: Colors.white)),
                            content: Text(
                              "Это уже потом не отменить ес что, так к слову",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    todoController.removeTodo(todo.id);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Удаляй, плевать!!!",
                                      style: TextStyle(color: Colors.white))),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Чёта передумал...",
                                      style: TextStyle(color: Colors.white)))
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.remove_moderator,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
