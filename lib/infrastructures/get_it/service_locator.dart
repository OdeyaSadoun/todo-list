import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/bl/todo_bloc/todo_bloc.dart';
import 'package:todo_list_app/domain/models/managers/json_manager.dart';
import 'package:todo_list_app/domain/repository/todo_repository.dart';
import 'package:todo_list_app/infrastructures/interfaces/i_json_manager.dart';
import 'package:todo_list_app/infrastructures/interfaces/i_todo_repository.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<EventBus>(() => EventBus()); 
  getIt.registerLazySingleton<IJsonManager>(() => JsonManager());
  getIt.registerLazySingleton<ITodoRepository>(() => TodoRepository(jsonManager: getIt<IJsonManager>()));
  getIt.registerFactory<TodoBloc>(() => TodoBloc(jsonManager: getIt<IJsonManager>(), eventBus: getIt<EventBus>()));
}
