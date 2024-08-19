//todo_event.dart
import 'package:todo_list_app/domain/models/data_classes/todo_item.dart';

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

class TodosLoadedEvent extends TodoEvent {
  final List<TodoItem> todos;

  TodosLoadedEvent({required this.todos});
}