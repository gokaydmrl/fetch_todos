import 'package:flutter/material.dart';
import 'package:poke/todo.dart';
import 'package:provider/provider.dart';

import 'fetch_todos_provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    var fetchAsyncTodos = context.watch<FetchAsyncTodos>();
    final rez = fetchAsyncTodos.getAs();
    return FutureBuilder<List<Todo>>(
      future: rez,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              for (var i = 0; i < snapshot.data!.length; i++)
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Icon(snapshot.data![i].completed
                          ? Icons.done_all_outlined
                          : Icons.not_interested),
                      Text(
                        snapshot.data![i].title,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
