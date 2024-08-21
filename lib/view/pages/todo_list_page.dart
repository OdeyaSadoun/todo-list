import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bl/todo_bloc/todo_bloc.dart';
import '../../bl/todo_bloc/todo_event.dart';
import '../../bl/todo_bloc/todo_state.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) {
                      BlocProvider.of<TodoBloc>(context).add(ToggleTodo(
                        id: todo.id,
                      ));
                    },
                  ),
                  onLongPress: () {
                    BlocProvider.of<TodoBloc>(context).add(DeleteTodo(
                      id: todo.id,
                    ));
                  },
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No todos'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodoDialog(BuildContext parentContext) {
    final titleController = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<TodoBloc>(parentContext).add(AddTodo(
                  title: titleController.text,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
