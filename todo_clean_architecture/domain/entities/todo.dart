// 엔티티는 비즈니스 로직만 포함
class Todo {
  Todo({
    required this.id,
    required this.title,
    this.createdAt,
    this.updatedAt,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final bool isCompleted;
  final String? createdAt;
  final String? updatedAt;

  get slug => title.toLowerCase().replaceAll(' ', '-');
}
