import '../../domain/models/data_classes/todo_item.dart';

class TodoAddedEvent {
  final TodoItem todo;

  TodoAddedEvent({required this.todo});
}

class TodoDeletedEvent {
  final String todoId;

  TodoDeletedEvent({required this.todoId});
}
