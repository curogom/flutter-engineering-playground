import 'package:flutter/material.dart';

import 'presentation/presentation.dart';
import 'domain/domain.dart';
import 'data/data.dart';

main() {
  runApp(
    MaterialApp(
      // 적절한 의존성 주입 라이브러리를 사용해야 합니다
      home: TodoListScreen(
        todoState: TodoState(
          getTodosUseCase: GetTodosUseCase(
            todoRepository: TodoRepositoryImpl(
              localDataSource: LocalTodoDataSource(),
              remoteDataSource: RemoteTodoDataSource(),
            ),
          ),
        ),
      ),
    ),
  );
}
