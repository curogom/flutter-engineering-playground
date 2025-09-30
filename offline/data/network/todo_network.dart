import '../../interface.dart';
import '../model/todo.dart';

class HttpClientFake {
  Future<dynamic> get(String path) async {
    return [];
  }

  Future<List<Todo>> post(String path) async {
    return [];
  }
}

class TodoNetworkDataSource implements TodoService {
  TodoNetworkDataSource(this.httpClient);

  final HttpClientFake httpClient;

  @override
  Future<Todo?> get(String id) async {
    // 네트워크에서 todos 가져오기
    final Todo? todo = await httpClient.get('/todos/$id');

    // repository에 todos 반환
    return todo;
  }

  @override
  Future<List<Todo>> getAll() async {
    // 네트워크에서 todos 가져오기
    final List<Todo> todos = await httpClient.get('/todos');

    // repository에 todos 반환
    return todos;
  }

  @override
  Future<void> save(Todo listTodos) async {
    httpClient.post('/save-todos');
    return;
  }

  @override
  Future<void> refresh(List<Todo> listTodos) async {
    return;
  }
}
