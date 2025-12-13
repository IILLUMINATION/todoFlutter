import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:todo_flutter/screens/menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tasks = signal({});
  print(tasks.value);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MenuScreen(), debugShowCheckedModeBanner: false);
  }
}
