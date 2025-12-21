import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:todo_flutter/screens/menu_screen.dart';
import 'package:todo_flutter/utils/file_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initStorage();
  //инициализация хранилища с файлами и функций для работы с ними

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
