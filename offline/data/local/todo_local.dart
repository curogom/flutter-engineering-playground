import '../../interface.dart';
import 'db/local_db.dart';
import '../model/todo.dart';

class TodoLocalDataSource implements TodoService {
  TodoLocalDataSource(this.db);

  final TodoDatabase db;

  @override
  Future<Todo?> get(String id) async {
    // 로컬 데이터베이스에서 todos 가져오기
    final Todo? todo = await db.get(id);

    // repository에 todos 반환
    return todo;
  }

  @override
  Future<List<Todo>> getAll() async {
    // 로컬 데이터베이스에서 todos 가져오기
    final List<Todo> todos = await db.getAll();

    // repository에 todos 반환
    return todos;
  }

  @override
  Future<List<Todo>> refresh(List<Todo> listTodos) async {
    // todos를 로컬 모델로 변환
    return listTodos;
  }

  @override
  Future<void> save(Todo todo) async {
    return db.write(todo);
  }
}
