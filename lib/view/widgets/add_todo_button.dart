import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_todo_dialog.dart';
import '../../bl/todo_bloc/todo_bloc.dart';
import 'package:get_it/get_it.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => BlocProvider.value(
            value: GetIt.I<TodoBloc>(), 
            child: const AddTodoDialog(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
