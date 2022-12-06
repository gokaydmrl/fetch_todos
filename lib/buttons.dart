import 'package:flutter/material.dart';
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
    return Consumer<FetchAsyncTodos>(
      builder: (context, fetchAsyncTodos, child) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  if (fetchAsyncTodos.userId > 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  tooltip: fetchAsyncTodos.userId < 2
                      ? "NO PREVIOUS USER"
                      : "PREVIOUS USER",
                  onPressed: fetchAsyncTodos.userId < 2
                      ? null
                      : () {
                          setState(() {
                            fetchAsyncTodos.decrUserIdValue();
                          });
                          fetchAsyncTodos.isLoading = true;
                          fetchAsyncTodos.getAs();
                        },
                  child: const Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                tooltip:
                    fetchAsyncTodos.userId > 9 ? "NO NEXT USER" : "NEXT USER",
                onPressed: fetchAsyncTodos.userId > 9
                    ? null
                    : () {
                        setState(() {
                          fetchAsyncTodos.incrUserIdValue();
                        });
                        fetchAsyncTodos.isLoading = true;
                        fetchAsyncTodos.getAs();
                      },
                child: const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
