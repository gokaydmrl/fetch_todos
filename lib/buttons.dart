import 'package:flutter/material.dart';
import 'package:poke/todo.dart';
import 'package:provider/provider.dart';

import 'fetch_todos_provider.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    
    final int userId = context.watch<FetchAsyncTodos>().userId;
    final void Function() decreaseUserId =
        context.watch<FetchAsyncTodos>().decrUserIdValue;
    final void Function() increaseUserId =
        context.watch<FetchAsyncTodos>().incrUserIdValue;
    final Future<List<Todo>> Function() fetchTodos =
        context.watch<FetchAsyncTodos>().getAs;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  if (fetchAsyncTodos.userId > 1)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
                tooltip: userId < 2 ? "NO PREVIOUS USER" : "PREVIOUS USER",
                onPressed: userId < 2
                    ? null
                    : () {
                        setState(() {
                          decreaseUserId();
                        });
                        fetchTodos();
                      },
                child: const Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 50,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              tooltip: userId > 9 ? "NO NEXT USER" : "NEXT USER",
              onPressed: userId > 9
                  ? null
                  : () {
                      setState(() {
                        increaseUserId();
                      });
                      fetchTodos();
                    },
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
