import '../model/local_datasource.dart';
import '../model/model.dart';
import '../model/remote_datasource.dart';
import 'command.dart';

class TodoViewModel {
  final RemoteTodoDataSource _remoteDataSource;
  final LocalTodoDataSource _localDataSource;
  List<Todo> _todos = [];

  late final Command fetchTodosCommand;

  TodoViewModel(
    this._remoteDataSource,
    this._localDataSource,
  ) {
    fetchTodosCommand = Command(_fetchTodos);
  }

  List<Todo> get todos => _todos;

  Future<void> _fetchTodos() async {
    _todos = [];
    try {
      _todos = await _remoteDataSource.fetchTodos();
    } catch (e) {
      _todos = await _localDataSource.fetchTodos();
    }
  }

  // 필요에 따라 더 많은 command 메서드를 추가하세요
}

// 일반적으로 이것은 싱글톤이거나
// 의존성 주입 프레임워크를 사용해야 합니다
final TodoViewModel todoViewModelInstance = TodoViewModel(
  RemoteTodoDataSource(),
  LocalTodoDataSource(),
);
