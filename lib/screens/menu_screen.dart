import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';
import 'package:todo_flutter/models/todo.dart';

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
            Text(
              "TODO",
              style: TextStyle(color: Colors.white),
            ),
            Watch((context) {
              final list = tasks();

              if (list.isEmpty) {
                return const Text("Пусто");
              }

              return ListView();
            })
          ],
        ),
      ),
    );
  }
}
