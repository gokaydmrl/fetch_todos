import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:poke/buttons.dart';
import 'package:poke/child.dart';
import 'package:poke/header.dart';
import 'package:poke/todo.dart';
import 'package:poke/todo_list.dart';
import 'package:provider/provider.dart';
import 'package:poke/fetch_todos_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => FetchAsyncTodos(), child: const MyApp()),
  );
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
  String val = "qwe";

  ///
  void changeval() {
    setState(() {
      val = "foo";
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  var fetchAsyncTodos = context.watch<FetchAsyncTodos>();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Header(),
            TodoList(),
            Buttons(),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*
Builder(
                        builder: (context) =>
                            Child(aval: val, changeValFunc: changeval))
*/