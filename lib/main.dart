import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bl/todo_bloc/todo_bloc.dart';
import 'infrastructures/get_it/service_locator.dart';
import 'view/pages/todo_list_page.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => getIt<TodoBloc>(),
        child: const TodoListPage(),
      ),
    );
  }
}
