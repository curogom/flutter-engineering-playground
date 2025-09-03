# Flutter Engineering Playground

Flutter Engineering 번역서의 예제 코드를 모아둔 저장소입니다.

## 📖 출처

이 저장소의 코드는 **Flutter Engineering** 책의 예제 코드를 기반으로 합니다.

- **원본 저장소**: [https://github.com/mhadaily/flutterengineering_examples/tree/main/playground/lib](https://github.com/mhadaily/flutterengineering_examples/tree/main/playground/lib)
- **저자**: Majid Hajian (mhadaily)

## 📚 주요 아키텍처 패턴

### State Management & Architecture
- **MVVM Pattern** (`todo_mvvm/`) - ViewModel과 Command 패턴을 활용한 구조
- **BLoC Pattern** (`todo_bloc_pattern/`) - Business Logic Component 패턴 구현
- **Clean Architecture** (`todo_clean_architecture/`) - 도메인 중심 클린 아키텍처
- **Repository Pattern** (`todo_repository_patterns/`) - 데이터 접근 추상화
- **3-Layer Architecture** (`3-layer/`) - 전통적인 계층형 아키텍처
- **Microkernel** (`Microkernel/`) - 플러그인 기반 아키텍처

### Advanced Flutter Concepts
- **Parallelism** (`parallelism/`) - Isolates와 동시성 처리
- **FFI Integration** - Native 코드 연동 (libhello_world.dylib)
- **Custom Painters** (`custompainters/`) - 커스텀 렌더링
- **State Restoration** (`state_restoration/`) - 앱 상태 복원
- **Localization** (`l10n/`) - 다국어 지원 (en, fr, fa, nb)

### Design Patterns & Best Practices
- **Design Patterns** (`design_patterns/`) - GoF 패턴 구현
- **Dependency Injection** (`DI/`) - 의존성 주입 패턴
- **Event-Driven Architecture** (`EDA/`) - 이벤트 기반 아키텍처
- **OOP Concepts** (`oop/`) - Mixin 등 객체지향 개념

## 🛠 주요 구성 요소

### UI & UX
- `theme.dart` - 테마 관리 시스템
- `responsive.dart` - 반응형 디자인 유틸리티
- `accessibility.dart` - 접근성 기능
- `labeled_divider.dart` - 커스텀 위젯 예제

### Application Features
- `app_lifecycle.dart` - 앱 생명주기 관리
- `widget_lifecycle.dart` - 위젯 생명주기 처리
- `force_upgrade/` - 강제 업데이트 구현
- `offline/` - 오프라인 모드 처리
- `feature_flag/` - 기능 플래그 관리

### Security & Performance
- `security.dart` - 보안 구현 예제
- `note_secure_service.dart` - 안전한 서비스 패턴
- `test_doubles.dart` - 테스트 더블 패턴
- `tell-dont-ask.dart` - Tell, Don't Ask 원칙

### Advanced Topics
- `class_modifiers.dart` - Dart 클래스 수정자
- `codegen/` - 코드 생성 예제
- `env/` - 환경 설정 관리
- `shaders/` - 셰이더 예제

## 🚀 실행 방법

이 저장소는 표준 Flutter 프로젝트 구조가 아닌 개별 실험 파일들의 모음입니다:

```bash
# 개별 Dart 파일 실행
dart <filename>.dart

# 예시
dart main.dart
dart todo_mvvm/main.dart
```

## 📁 프로젝트 구조

```
.
├── todo_**/           # 다양한 아키텍처 패턴의 TODO 앱 구현
├── design_patterns/   # 디자인 패턴 예제
├── parallelism/       # 병렬 처리 예제
├── l10n/             # 다국어 지원 파일
├── shaders/          # 셰이더 예제
└── *.dart            # 개별 개념 실험 파일
```

## 📚 학습 목적

이 저장소는 Flutter Engineering 책에서 다루는 다음 주제들을 실습할 수 있습니다:
- 다양한 상태 관리 패턴의 실제 구현
- 아키텍처 패턴별 장단점 비교
- Flutter의 고급 기능 활용법
- 성능 최적화 기법
- 보안 및 접근성 구현

## 📝 License

MIT License - 자세한 내용은 [LICENSE](LICENSE) 파일 참조

원본 코드의 라이선스를 확인하려면 [원본 저장소](https://github.com/mhadaily/flutterengineering_examples)를 참조하세요.

---
*Flutter Engineering 책의 예제 코드 모음*