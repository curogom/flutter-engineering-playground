import 'package:flutter/foundation.dart';

typedef CommandAction = Future<void> Function();

class Command extends ChangeNotifier {
  final CommandAction _action;
  bool _isExecuting = false;

  Command(this._action);

  bool get isExecuting => _isExecuting;

  Future<void> execute() async {
    if (_isExecuting) return;
    _isExecuting = true;
    // 실행 시작 시 리스너들에게 알림
    notifyListeners();

    try {
      await _action();
    } finally {
      _isExecuting = false;
      // 실행 종료 시 리스너들에게 알림
      notifyListeners();
    }
  }
}
