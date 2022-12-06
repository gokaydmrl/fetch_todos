import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:poke/child.dart';
import 'package:poke/todo.dart';
import 'package:provider/provider.dart';

class FetchAsyncTodos extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(
    // connectTimeout: 10000,
    // receiveTimeout: 10000,
    contentType: 'application/json',
    responseType: ResponseType.plain,
  ));

  int userId = 1;
  void incrUserIdValue() {
    userId = userId + 1;
    notifyListeners();
  }

  void decrUserIdValue() {
    userId = userId - 1;
    notifyListeners();
  }

  bool isLoading = false;

  Future<List<Todo>> getAs() async {
    try {
      final res = await _dio.get('https://jsonplaceholder.typicode.com/todos/');
      if (res.statusCode == 200) {
        final reso = json.decode(res.toString());
        final filteredTodo = (reso as List)
            .map((item) => Todo.fromJson(item))
            .toList()
            .where((i) => i.userId == userId)
            .toList();
        isLoading = false;
        notifyListeners();
        return filteredTodo;
      } else {
        final reso = json.decode(res.toString());
        isLoading = false;
        return (reso as List).map((item) => Todo.fromJson(item)).toList();
      }
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();

      return Future.error(e);
    }
  }
}
