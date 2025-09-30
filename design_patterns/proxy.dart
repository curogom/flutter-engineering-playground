import 'package:flutter/material.dart';

abstract class AccessibleWidget {
  Widget build(BuildContext context);
}

// 실제 위젯
class RestrictedContentWidget implements AccessibleWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Restricted Content',
      key: Key('restrictedContentKey'),
    );
  }
}

// Proxy
class AccessControlProxyWidget extends StatelessWidget {
  final AccessibleWidget protectedWidget;
  final bool hasAccess;

  const AccessControlProxyWidget({
    super.key,
    required this.protectedWidget,
    required this.hasAccess,
  });

  @override
  Widget build(BuildContext context) {
    return hasAccess
        ? protectedWidget.build(context)
        : const Text('Access Denied');
  }
}

checkUserAccess() {
  return true;
}

// 앱에서의 사용 예시
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: AccessControlProxyWidget(
        protectedWidget: RestrictedContentWidget(),
        hasAccess: checkUserAccess(), // 사용자 접근 권한을 확인하는 함수
      ),
    ),
  ));
}
