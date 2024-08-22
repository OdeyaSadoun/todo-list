import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bl/todo_bloc/todo_bloc.dart';
import '../../bl/todo_bloc/todo_state.dart';
import 'todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoLoaded) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return TodoListItem(todo: todo);
            },
          );
        } else if (state is TodoError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No todos'));
        }
      },
    );
  }
}
