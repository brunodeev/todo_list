// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Adicione uma tarefa",
                    ),
                  ),
                ),
                SizedBox(width: 7),
                ElevatedButton(
                  onPressed: () {
                    String text = todoController.text;
                    setState(() {
                      todos.add(text);
                    });
                    todoController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(14),
                    primary: Color(0xff58D8B5),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (String todo in todos)
                    ListTile(
                      title: Text(todo),
                      subtitle: Text('04/08/2022'),
                      leading: Icon(
                        Icons.save,
                        size: 30,
                      ),
                      onTap: () {
                        print('Tarefa: $todo');
                      },
                    ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Você possui 0 tarefas pendentes',
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff58D8B5),
                    padding: EdgeInsets.all(14),
                  ),
                  onPressed: () {},
                  child: Text('Limpar Tudo'),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
