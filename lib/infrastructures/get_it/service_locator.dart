import 'package:get_it/get_it.dart';
import '../../domain/models/managers/json_manager.dart';
import '../interfaces/i_json_manager.dart';
import '../../domain/repository/todo_repository.dart';
import '../interfaces/i_todo_repository.dart';
import '../../bl/todo_bloc/todo_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<IJsonManager>(() => JsonManager(fileName: 'todos.json'));
  getIt.registerLazySingleton<ITodoRepository>(() => TodoRepository(jsonManager: getIt<IJsonManager>()));
  getIt.registerFactory<TodoBloc>(() => TodoBloc(repository: getIt<ITodoRepository>()));
}
