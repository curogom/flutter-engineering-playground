import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Logger {
  void log(String message);
}

abstract mixin class ServiceLoggerAbstractMixinClass {
  void log(String message); // 추상 메서드

  void toPrint() {
    // 본문이 있는 메서드
    if (kDebugMode) {
      print('ClassName: ${objectRuntimeType(this, '')}');
    }
  }
}

mixin class ServiceLoggerMixinClass implements Logger {
  @override
  void log(String message) {
    if (kDebugMode) {
      print('${objectRuntimeType(this, 'ServiceClass')}: $message');
    }
  }
}

mixin ServiceLoggerMixin implements Logger {
  @override
  void log(String message) {
    if (kDebugMode) {
      print('${objectRuntimeType(this, 'Service')}: $message');
    }
  }
}

mixin WidgetLoggerMixin on Widget implements Logger {
  @override
  void log(String message) {
    if (kDebugMode) {
      print('${objectRuntimeType(this, 'Widget')}: $message');
    }
  }
}

class CustomWidget extends StatelessWidget
    with ServiceLoggerAbstractMixinClass {
  CustomWidget({super.key}) {
    toPrint(); // mixin에서 가져옴
  }

  @override
  Widget build(BuildContext context) {
    log('build');

    return Container();
  }

  @override
  void log(String message) {
    print('CustomWidget: $message');
  }
}

class CustomServiceLoggerAbstractMixinClass
    extends ServiceLoggerAbstractMixinClass {
  @override
  void log(String message) {
    // TODO: implement log
  }
}
