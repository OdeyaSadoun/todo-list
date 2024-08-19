import '../../infrastructures/interfaces/i_todo_repository.dart';
import '../../infrastructures/interfaces/i_json_manager.dart';
import '../models/data_classes/todo_item.dart';

class TodoRepository implements ITodoRepository {
  final IJsonManager jsonManager;

  TodoRepository({required this.jsonManager});

  @override
  Future<List<TodoItem>> loadTodos() async {
    try {
      // העברת הנתיב של הקובץ JSON כפרמטר לפונקציה readJson
      final jsonData = await jsonManager.readJson('todos.json');
      final List<dynamic> todosJson = jsonData['todos'] ?? [];

      return todosJson.map((json) => TodoItem.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading todos: $e');
    }
  }

  @override
  Future<void> saveTodos(List<TodoItem> todos) async {
    try {
      final todosJson = todos.map((todo) => todo.toJson()).toList();
      await jsonManager.writeJson('todos.json', {'todos': todosJson});
    } catch (e) {
      throw Exception('Error saving todos: $e');
    }
  }

}
