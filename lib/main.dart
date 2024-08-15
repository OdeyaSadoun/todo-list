import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bl/todo_bloc/todo_bloc.dart';
import 'infrastructures/get_it/service_locator.dart';
import 'view/pages/todo_list_page.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => getIt<TodoBloc>(),
        child: TodoListPage(),
      ),
    );
  }
}
