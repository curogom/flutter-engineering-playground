class AppConfig {
  static AppConfig? _instance;

  AppConfig._internal();

  static AppConfig get instance {
    _instance ??= AppConfig._internal();
    return _instance!;
  }

  // 싱글톤 리셋, 테스트에 유용함
  static void reset() => _instance = null;

  String appName = 'My Flutter App';
  String appVersion = '1.0.0';

  // 추가 구성 설정...
}
