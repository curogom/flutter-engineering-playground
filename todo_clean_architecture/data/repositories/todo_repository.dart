import '../../domain/contracts/todo_data_contract.dart';
import '../../domain/entities/todo.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final LocalTodoDataSource localDataSource;
  final RemoteTodoDataSource remoteDataSource;

  @override
  Future<List<Todo>> fetchTodos() async {
    try {
      return await remoteDataSource.fetchTodos();
    } catch (e) {
      return localDataSource.fetchTodos();
    }
  }

  @override
  Future<void> addTodo(Todo todo) async {
    // 로컬 및 원격 데이터 소스를 결합하는 로직 구현
  }

  @override
  Future<void> deleteTodo(String id) async {
    // 로컬 및 원격 데이터 소스를 결합하는 로직 구현
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    // 로컬 및 원격 데이터 소스를 결합하는 로직 구현
  }
}
