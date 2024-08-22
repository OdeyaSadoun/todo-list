import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bl/todo_bloc/todo_bloc.dart';
import '../../bl/todo_bloc/todo_event.dart';
import '../../domain/models/data_classes/todo_item.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem todo;

  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(DeleteTodo(
                id: todo.id,
              ));
            },
          ),
          Checkbox(
            value: todo.isCompleted,
            onChanged: (_) {
              BlocProvider.of<TodoBloc>(context).add(ToggleTodo(
                id: todo.id,
              ));
            },
          ),
        ],
      ),
      onLongPress: () {
        BlocProvider.of<TodoBloc>(context).add(DeleteTodo(
          id: todo.id,
        ));
      },
    );
  }
}
