import '../../domain/models/data_classes/todo_item.dart';

abstract class ITodoRepository {
  Future<List<TodoItem>> loadTodos();
  Future<void> saveTodos(List<TodoItem> todos);
}
