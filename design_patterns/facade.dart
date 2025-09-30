// 복잡한 서브시스템 클래스들
import 'package:flutter/material.dart';

class NetworkManager {
  Future<String> fetchData() async {
    // 구현부...
    return 'Data';
  }
}

class DataProcessor {
  String processData(String data) {
    // 구현부...
    return 'Processed Data';
  }
}

// Facade
class DataFacade {
  final NetworkManager _networkManager = NetworkManager();
  final DataProcessor _dataProcessor = DataProcessor();

  Future<String> fetchDataAndProcess() async {
    String data = await _networkManager.fetchData();
    return _dataProcessor.processData(data);
  }
}

// Flutter 앱에서의 사용 예시
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: FutureBuilder<String>(
        future: DataFacade().fetchDataAndProcess(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.data ?? 'No data');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ),
  ));
}
