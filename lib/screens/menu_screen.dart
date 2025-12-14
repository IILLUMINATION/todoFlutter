import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:todo_flutter/controllers/todo_controller.dart';
import 'package:todo_flutter/widgets/todo_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  //конструктор класса
  //класс наследуется от StatefulWidget изменяемый виджет который не статичен

  @override
  //переопределяем стандартный метод

  //State обязателен для стейтфула. создаёт объект состояния
  State<MenuScreen> createState() {
    return _MenuScreenState();
    //возвращаем в качестве состояния наш собственный самописный класс
  }
}

//класс состояния и билда отображения, наследуется от State
class _MenuScreenState extends State<MenuScreen> {
  //указываем тип виджета с которым связано состояние через <>
  late final TextEditingController _textController;

  //лейт это значит что мы объявляем переменную и пока что там нету данных но мы обещаем флаттеру что будут позже

  //переопределяем стандартные методы, нужно чтобы не было утечек памяти связанных с текстовым полем
  @override
  //инициализация состояния
  void initState() {
    super.initState();
    //чёто типо стандартного бойлерпринта всегда нужно писать в первую очередь кроме диспосе по моему
    _textController = TextEditingController();
    //объявляем контрллер текстовому полю
  }

  //тут всё плюс минус также
  @override
  void dispose() {
    _textController.dispose();
    //вызываем его уже после очистки
    super.dispose();
  }

  //создаём приватную функцию для добавления задач которая ничего не возвращает т.к void
  void _addTask() {
    //берём с текстового контроллера текущий текст из поля
    final text = _textController.text;

    //с помощью нашего контроллера добавляем задачу у нас аргумент 1 это тайтл
    todoController.addTodo(text);

    //чистим поле чтобы текста не было старого
    _textController.clear();
  }

  //переопределяем стандартный метод билд
  @override
  Widget build(BuildContext context) {
    //возвращаем виджет скаффолд типо шаблон базового экрана база крч
    return Scaffold(
      //ставим цвет фона
      backgroundColor: Colors.black,
      //указваем тело и делаем внутренности по центру
      body: Center(
        child: Column(
          //стандартную центровку ставим на центр по y так как это колумн ряд крч
          mainAxisAlignment: MainAxisAlignment.center,
          //заполняем детей
          children: [
            //просто пустота для красоты
            SizedBox(
              height: 50,
            ),
            //название прилоения
            Text(
              "TODO",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            //пустота
            SizedBox(
              height: 20,
            ),
            //даём с помощью экспандеда вотчу расшириться на фулл пространство
            Expanded(
              //ставим вотч, он будет наблюдать и всё что в нём само перестроится
              child: Watch((context) {
                //список задач с подпиской на реактивность
                //вызываем внутри вотча чтобы было актуально
                final taskList = todoController.tasks.watch(context);

                //проверяем что лист задач пуст, если да то текст юзеру пихаем
                if (taskList.isEmpty) {
                  return const Text(
                    "Пусто",
                    style: TextStyle(color: Colors.white),
                  );
                }

                //если не пуст список билдим через ListView.builder на основе списка всё, это самый проивзодительный способ
                return ListView.builder(
                  //ставим длину списка как у листа нашего
                  itemCount: taskList.length,
                  //в билдере у нас два аргумента контекст и индекс
                  //индекс это текущий элемент
                  itemBuilder: (context, index) {
                    //берём по индексу из листа тудушку
                    final todo = taskList[index];
                    //на основе уже сделанного в другом экране виджета строим всё
                    return TodoWidget(
                      //тут чисто базовые аргументы
                      todo: todo,
                      onDelete: () {
                        //тут указываем что делать при удалении
                        //удаляем по индексу из листа
                        taskList.removeAt(index);
                      },
                    );
                  },
                );
              }),
            ),
            //текстовое поле
            TextField(
              //указываем наш контроллер
              controller: _textController,
              onSubmitted: (_) {
                // (_) используется потому что передаёт он по умолчанию параметр
                //он передаёт текст из поля, но мы то юзаем текст по .text
                //поэтому ставим типо затычка
                //вызываем добавление задачи вообще тут можно было бы передать как аргумент тайтл но ладно

                _addTask();
              },
            ),
            //пустота
            SizedBox(
              height: 20,
            ),
            //кнопка
            ElevatedButton(
                //функция при нажатии, ну тут опять так вызываем добавление задачи
                onPressed: () {
                  _addTask();
                },
                //внутренности кнопки
                child: Text("Добавить задачу")),
            //пустота
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
