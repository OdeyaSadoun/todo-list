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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) {
                          BlocProvider.of<TodoBloc>(context).add(ToggleTodo(
                            id: todo.id,
                          ));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<TodoBloc>(context).add(DeleteTodo(
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bl/todo_bloc/todo_bloc.dart';
// import '../../bl/todo_bloc/todo_event.dart';
// import '../widgets/todo_list.dart';
// import '../widgets/add_todo_button.dart';
// import 'package:get_it/get_it.dart';

// class TodoListPage extends StatelessWidget {
//   const TodoListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GetIt.I<TodoBloc>()..add(LoadTodos()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Todo List'),
//         ),
//         body: const TodoList(),
//         floatingActionButton: const AddTodoButton(),
//       ),
//     );
//   }
// }
