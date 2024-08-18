import 'package:flutter_bloc/flutter_bloc.dart';
import '../../infrastructures/interfaces/i_todo_repository.dart';
import '../../domain/models/data_classes/todo_item.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../../infrastructures/events/event_bus.dart';
import '../../infrastructures/events/todo_events.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ITodoRepository repository;

  TodoBloc({required this.repository}) : super(TodoInitial()) {
 on<LoadTodos>((event, emit) async {
      emit(TodoLoading()); // שינוי המצב לטעינה
      try {
        final todos = await repository.loadTodos(); // קריאת המשימות מה-Repository
        emit(TodoLoaded(todos: todos)); // מצב נטען עם המשימות
      } catch (e) {
        emit(TodoError(message: e.toString())); // אם יש שגיאה, מצב של שגיאה
      }
    });

    // מיד לאחר האתחול, אנו שולחים את האירוע לטעינת המשימות
    add(LoadTodos());
  }

  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodos) {
      yield TodoLoading();
      try {
        final todos = await repository.loadTodos();
        yield TodoLoaded(todos: todos);
      } catch (e) {
        yield TodoError(message: e.toString());
      }
    } else if (event is AddTodo) {
      if (state is TodoLoaded) {
        final List<TodoItem> updatedTodos =
            List.from((state as TodoLoaded).todos)
              ..add(TodoItem(
                id: DateTime.now().toString(),
                title: event.title,
              ));

        yield TodoLoaded(todos: updatedTodos);
        repository.saveTodos(updatedTodos);

        eventBus.fire(TodoAddedEvent(todo: updatedTodos.last));
      }
    } else if (event is DeleteTodo) {
      if (state is TodoLoaded) {
        final List<TodoItem> updatedTodos = (state as TodoLoaded)
            .todos
            .where((todo) => todo.id != event.id)
            .toList();

        yield TodoLoaded(todos: updatedTodos);
        repository.saveTodos(updatedTodos);

        eventBus.fire(TodoDeletedEvent(todoId: event.id));
      }
    }
  }
}
