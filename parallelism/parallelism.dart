import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// JSON을 파싱하는 함수. 백그라운드 Isolate에서 실행됩니다.
List<dynamic> parseJson(String jsonString) {
  return json.decode(jsonString);
}

class LargeJsonParserWidget extends StatefulWidget {
  const LargeJsonParserWidget({super.key});

  @override
  LargeJsonParserWidgetState createState() => LargeJsonParserWidgetState();
}

class LargeJsonParserWidgetState extends State<LargeJsonParserWidget> {
  bool isLoading = false;
  List<String> jsonData = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  // JSON을 로드하고 파싱하는 함수
  Future<void> loadJsonData() async {
    setState(() => isLoading = true);

    // 큰 JSON 문자열 로드를 시뮬레이션
    final jsonString =
        await loadJsonString(); // 이 함수가 JSON 문자열을 가져온다고 가정

    // compute를 사용하여 백그라운드에서 JSON 파싱
    final parsedJson = await compute(parseJson, jsonString);

    setState(() {
      jsonData = parsedJson.cast<String>();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Large JSON Parser'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jsonData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jsonData[index]),
                );
              },
            ),
    );
  }

  // 인터넷에서 매우 큰 JSON 문자열을 로드한다고 상상해보세요
  Future<String> loadJsonString() async {
    return '["John Smith", "Majid Hajian"]';
  }
}

// 장기 실행 Isolate
class ComputationModel {
  final int iterations;
  final int factor;

  ComputationModel(this.iterations, this.factor);
}

void computeSum(ComputationModel model) {
  int sum = 0;
  for (int i = 1; i <= model.iterations; i++) {
    sum += i * model.factor;
  }
  debugPrint('Computed Sum: $sum');
}

void workerTask(SendPort mainSendPort) async {
  ReceivePort workerReceivePort = ReceivePort();
  mainSendPort.send(workerReceivePort.sendPort);

  await for (var message in workerReceivePort) {
    if (message is List) {
      String mainMessage = message[0];
      debugPrint(mainMessage);

      SendPort replyPort = message[1];
      replyPort.send('Hello from Worker');
    }
  }
}

createIsolate() async {
  Isolate.spawn<ComputationModel>(computeSum, ComputationModel(10000, 5));

  ReceivePort mainReceivePort = ReceivePort();
  await Isolate.spawn(workerTask, mainReceivePort.sendPort);

  SendPort workerSendPort = await mainReceivePort.first;
  ReceivePort responsePort = ReceivePort();

  workerSendPort.send(['Hello from Main', responsePort.sendPort]);

  final response = await responsePort.first;
  debugPrint('Response from Worker: $response');
}

main() async {
  createIsolate();

  runApp(
    const MaterialApp(
      home: LargeJsonParserWidget(),
    ),
  );
}