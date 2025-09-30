// scratch.dart
// 이 파일은 코드를 빠르게 테스트하고 실험하기 위한 임시 작업 공간입니다.
// Flutter 개념을 학습하거나 새로운 아이디어를 시도할 때 자유롭게 사용하세요.
//
// 사용 방법:
// 1. 이 파일에 테스트하고 싶은 코드를 작성합니다
// 2. main() 함수를 통해 실행합니다
// 3. 실험이 끝나면 코드를 정리하거나 다른 파일로 옮깁니다
//
// 팁: 이 파일은 git에 커밋하지 않고 로컬에서만 사용하는 것을 권장합니다.

import 'package:flutter/material.dart';

void main() {
  runApp(const ScratchApp());
}

class ScratchApp extends StatelessWidget {
  const ScratchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scratch Playground',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScratchHomePage(),
    );
  }
}

class ScratchHomePage extends StatelessWidget {
  const ScratchHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Scratch Playground'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '여기에 테스트하고 싶은 코드를 작성하세요!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 여기에 테스트 코드를 작성하세요
                print('버튼이 클릭되었습니다!');
              },
              child: const Text('테스트 버튼'),
            ),
          ],
        ),
      ),
    );
  }
}