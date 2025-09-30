import 'data/local/todo_local.dart';
import 'data/model/todo.dart';
import 'data/network/todo_network.dart';

class OfflineTodoRepository {
  OfflineTodoRepository(
    this.todoLocalDataSource,
    this.todoNetworkDataSource,
  );

  final TodoLocalDataSource todoLocalDataSource;
  final TodoNetworkDataSource todoNetworkDataSource;

  Stream<List<Todo>> getTodos() async* {
    // 로컬 데이터베이스에서 todos 가져오기
    final List<Todo> todos = await todoLocalDataSource.getAll();

    // UI로 todos 전달
    yield todos;
  }

  Future<void> write(Todo todo) async {
    // 로컬 데이터베이스에 todo 작성
    await todoLocalDataSource.save(todo);
  }
}
