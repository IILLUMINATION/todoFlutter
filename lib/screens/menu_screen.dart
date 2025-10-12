import 'package:flutter/material.dart';
import 'package:todo_flutter/screens/tasks_screen.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback callback;

  const Button({
    super.key,
    required this.icon,
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
      child: Row(
        children: [
          Text(text, style: TextStyle(color: Colors.white)),
          SizedBox(width: 10),
          Icon(icon, color: Colors.black),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Button> _listButtons = [
      Button(
        icon: Icons.book_online,
        text: "Мои задачи",
        callback: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TasksScreen()),
          );
        },
      ),
    ];

    List<Widget> _buildButtons() {
      List<Widget> widgets = [];

      for (int i = 0; i < _listButtons.length; i++) {
        widgets.add(_listButtons[i]);
        if (i != _listButtons.length - 1) {
          widgets.add(SizedBox(height: 10));
        }
      }

      return widgets;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("TODO", style: TextStyle(color: Colors.white, fontSize: 35)),
            Text(
              "Flutter",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            ..._buildButtons(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "версия 1.0.3",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
