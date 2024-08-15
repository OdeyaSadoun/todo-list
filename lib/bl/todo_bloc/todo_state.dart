import '../../domain/models/data_classes/todo_item.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoItem> todos;

  TodoLoaded({required this.todos});
}

class TodoError extends TodoState {
  final String message;

  TodoError({required this.message});
}
