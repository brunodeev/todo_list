// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_statements

import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelText: "Tarefa",
                        hintText: "Adicione uma tarefa",
                      ),
                    ),
                  ),
                  SizedBox(width: 7),
                  ElevatedButton(
                    onPressed: () {
                      String text = todoController.text;
                      setState(() {
                        Todo newTodo = Todo(
                          title: text,
                          dateTime: DateTime.now(),
                        );
                        todos.add(newTodo);
                      });
                      todoController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
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
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    for (Todo todo in todos)
                      TodoListItem(
                        todo: todo,
                        onDelete: onDelete,
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Você possui ${todos.length} tarefas pendentes',
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      primary: Color(0xff58D8B5),
                      padding: EdgeInsets.all(14),
                    ),
                    onPressed: showDeleteTodosConfirmationDialog,
                    child: Text('Limpar Tudo'),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tafera ${todo.title} foi removida com sucesso!',
          style: TextStyle(color: Colors.grey[700]),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          textColor: Color(0xff58D8B5),
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(milliseconds: 5000),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20)),
        title: Text('Atenção!'),
        content: Text('Tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            style: TextButton.styleFrom(
              primary: Color(0xff58D8B5),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Confirmar'),
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 228, 51, 20),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
