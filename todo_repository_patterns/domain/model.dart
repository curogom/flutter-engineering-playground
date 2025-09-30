// 모델 (엔티티) 클래스
import '../data/data_model.dart';
import 'sanitize.dart';

class Todo extends TodoDataModel {
  Todo({
    required super.id,
    required super.title,
    super.isCompleted,
    // 제목으로부터 URL 생성은 도메인 로직
    required this.slug,
  });

  final String slug;

  // 도메인을 위한 비즈니스 로직
  factory Todo.fromDataModel(TodoDataModel dataModel) {
    return Todo(
      id: dataModel.id,
      // 프레젠테이션 레이어로 전달되기 전에
      // 여기서 데이터 레이어의 데이터를 조작할 수 있습니다
      title: ValidatorUseCases.text(dataModel.title),
      slug: ValidatorUseCases.slugify(dataModel.title),
      isCompleted: dataModel.isCompleted,
    );
  }

  toDataModel() {
    return TodoDataModel(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }
}
