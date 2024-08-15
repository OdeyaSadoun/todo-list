abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;

  AddTodo({
    required this.title,
  });
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo({required this.id});
}

class ToggleTodo extends TodoEvent {
  final String id;

  ToggleTodo({required this.id});
}
