import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/todo_usecase.dart';
import 'events.dart';
import 'state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoUseCases todoUseCases;

  TodoBloc(this.todoUseCases) : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    // 기타 이벤트 핸들러들...
  }

  // 들어오는 이벤트 처리
  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final todos = await todoUseCases.getTodos();
      emit(TodosLoaded(todos));
    } catch (_) {
      emit(TodoError());
    }
  }
}

// typically this would be a singleton
// or you must use a dependency injection framework
final todoBlocInstance = TodoBloc(todosUseCasesInstance);
