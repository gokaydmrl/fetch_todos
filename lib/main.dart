import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:poke/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: "FETCH_JSON_TODOS_DYNAMICALLY"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Todo>> rez;
  int userIdValue = 1;

  List qwe = [];
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: 10000,
    receiveTimeout: 10000,
    contentType: 'application/json',
    responseType: ResponseType.plain,
  ));

  // Future<Todo> getHttp() async {
  //   try {
  //     final response =
  //         await _dio.get('https://jsonplaceholder.typicode.com/todos/');
  //     //  print("RESPONSE: $response");

  //     if (response.statusCode == 200) {
  //       print("response $response");
  //       print("bu ne:: ${Todo.fromJson(jsonDecode(response.toString()))}");
  //       return Todo.fromJson(jsonDecode(response.toString()));
  //     } else {
  //       throw Exception("failed");
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future<List<Todo>> getAs() async {
    try {
      final res = await _dio.get('https://jsonplaceholder.typicode.com/todos/');
      if (res.statusCode == 200 && mounted) {
        final reso = json.decode(res.toString());
        final filteredTodo = (reso as List)
            .map((item) => Todo.fromJson(item))
            .toList()
            .where((i) => i.userId == userIdValue)
            .toList();
        qwe = filteredTodo;
        return filteredTodo;
      } else {
        final reso = json.decode(res.toString());
        return (reso as List).map((item) => Todo.fromJson(item)).toList();
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  @override
  void initState() {
    super.initState();
    rez = getAs();
    print(" rez:: ${rez}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("userIdValue: $userIdValue");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            for (var i = 0; i < 20; i++)
              Flexible(
                child: FutureBuilder<List<Todo>>(
                  future: rez,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(snapshot.data![i].completed
                                ? Icons.done_all_outlined
                                : Icons.not_interested),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data![i].title,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (userIdValue > 1)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                            tooltip: "PREVIOUS USER",
                            onPressed: () {
                              setState(() {
                                userIdValue = userIdValue - 1;

                                rez = getAs();
                              });
                            },
                            child: const Icon(
                              Icons.arrow_circle_left_outlined,
                              size: 50,
                            )),
                      ),
                    if (userIdValue < 10)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          tooltip: "NEXT USER",
                          onPressed: () {
                            setState(() {
                              userIdValue = userIdValue + 1;
                            });
                            rez = getAs();
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
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
