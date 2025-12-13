import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';
import 'package:todo_flutter/models/todo.dart';
import 'package:todo_flutter/widgets/todo_widget.dart';
import 'package:uuid/uuid.dart';

final tasks = listSignal<Todo>([]);

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "TODO",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Watch((context) {
                final list = tasks();

                if (list.isEmpty) {
                  return const Text(
                    "Пусто",
                    style: TextStyle(color: Colors.white),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final todo = tasks[index];

                    return TodoWidget(
                      todo: todo,
                      onDelete: () {
                        tasks.removeAt(index);
                      },
                    );
                  },
                );
              }),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  var id = Uuid().v4();
                  tasks.add(Todo(id: id, title: 'Задача', isDone: false));
                },
                child: Text("Добавить задачу")),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
