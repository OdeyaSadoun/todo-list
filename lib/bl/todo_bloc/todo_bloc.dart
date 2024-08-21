import 'package:event_bus/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/infrastructures/interfaces/i_json_manager.dart';
import '../../domain/models/data_classes/todo_item.dart';
import '../../infrastructures/events/todo_events.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final EventBus _eventBus;
  final List<TodoItem> _todos = [];
  final IJsonManager jsonManager;

  TodoBloc({required this.jsonManager, required EventBus eventBus})
      : _eventBus = eventBus,
        super(TodoInitial()) {
    _startEventListening();
    _startEventBusListening();
    add(LoadTodos());
  }

  void _startEventListening() {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await _loadTodosFromJson();
        emit(TodoLoaded(todos: todos));

        _eventBus.fire(TodosLoadedEvent(todos: todos));
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });

    on<AddTodo>((event, emit) async {
      if (state is TodoLoaded) {
        final List<TodoItem> updatedTodos = List.from(_todos)
          ..add(TodoItem(
            id: DateTime.now().toString(),
            title: event.title,
          ));

        _todos.clear();
        List<TodoItem> todosAfterAdding =
            await _saveTodosToJson(updatedTodos, jsonManager);
        emit(TodoLoaded(todos: todosAfterAdding));
        _eventBus.fire(TodoAddedEvent(todo: updatedTodos.last));
      }
    });

    on<DeleteTodo>((event, emit) {
      if (state is TodoLoaded) {
        final List<TodoItem> updatedTodos =
            _todos.where((todo) => todo.id != event.id).toList();

        _todos.clear();
        _todos.addAll(updatedTodos);
        emit(TodoLoaded(todos: updatedTodos));
        _eventBus.fire(TodoDeletedEvent(todoId: event.id));
      }
    });
  }

  void _startEventBusListening() {
    // Implement logic to listen to external events from the event bus
  }

  Future<List<TodoItem>> _loadTodosFromJson() async {
    try {
      final jsonData = await jsonManager.readJson('todos.json');
      final List<dynamic> todosJson = jsonData['todos'] ?? [];
      return todosJson.map((json) => TodoItem.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading todos: $e');
    }
  }

  Future<List<TodoItem>> _saveTodosToJson(
      List<TodoItem> todos, IJsonManager jsonManager) async {
    try {
      final existingData = await jsonManager.readJson('todos.json');
      final List<dynamic> existingTodosJson = existingData['todos'] ?? [];
      List<TodoItem> existingTodos =
          existingTodosJson.map((json) => TodoItem.fromJson(json)).toList();
      final List<TodoItem> updatedTodos = List.from(existingTodos)
        ..addAll(todos);
      await jsonManager.writeJson('todos.json',
          {'todos': updatedTodos.map((todo) => todo.toJson()).toList()});

      return updatedTodos;
    } catch (e) {
      throw Exception("Failed to save todos");
    }
  }
}
