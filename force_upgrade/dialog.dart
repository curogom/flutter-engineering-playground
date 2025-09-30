import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// 중요 업데이트 고려와 함께 업데이트
// 다이얼로그를 표시하는 향상된 함수
void showUpdateDialog(
  BuildContext context, {
  bool isCritical = false,
}) {
  showDialog(
    context: context,
    // 업데이트 중요도에 따라 해제 가능 여부 제어
    barrierDismissible: !isCritical,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update Available'),
        content: Text(
          isCritical
              ? '''A critical update is available.
                Update now to continue using the app.'''
              : '''A new version of the app is available.
                Please update now for the
                latest features and improvements.''',
        ),
        actions: <Widget>[
          if (!isCritical)
            TextButton(
              child: const Text('Later'),
              // 중요하지 않은 업데이트의 경우 해제 허용
              onPressed: () => Navigator.of(context).pop(),
            ),
          TextButton(
            child: const Text('Update'),
            onPressed: () {
              // 다이얼로그 닫기
              Navigator.of(context).pop();
              // 업데이트를 위한 URL 열기
              _launchURL();
            },
          ),
        ],
      );
    },
  );
}

// 플랫폼 체크 및 에러 처리
void _launchURL() async {
  final url = kIsWeb
      ? Uri.parse('https://yourwebsite.com/update')
      : Platform.isAndroid
          ? Uri.parse(
              'https://play.google.com/store/apps/details?id=your.app.id')
          : Platform.isIOS
              ? Uri.parse(
                  'https://apps.apple.com/app/idyourAppId')
              // 다른 플랫폼을 위한 폴백 URL
              : Uri.parse(
                  'https://yourfallbackwebsite.com/update');

  if (!await launchUrl(url)) {
    // URL을 실행할 수 없는 경우 에러를 로그하거나
    // 사용자에게 문제를 알립니다
    debugPrint('Could not launch $url');
    // 사용자에게 알리기 위해 토스트나
    // 다른 다이얼로그를 표시하는 것을 고려하세요
  }
}

void checkForUpdate(BuildContext context) {
  // 실제 업데이트 확인 로직으로 교체
  const isUpdateAvailable = true;
  // 업데이트의 중요도에 따라 교체
  const isCritical = false;

  if (isUpdateAvailable) {
    showUpdateDialog(context, isCritical: isCritical);
  }
}
