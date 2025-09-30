import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class SyncManager {
  final SyncQueue syncQueue;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  SyncManager(this.syncQueue) {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      syncQueue.processQueue();
    }
  }
}

class SyncQueue {
  final List<SyncOperation> _queue = [];

  void addToQueue(SyncOperation operation) {
    _queue.add(operation);
  }

  Future<void> processQueue() async {
    while (_queue.isNotEmpty) {
      SyncOperation operation = _queue.removeAt(0);
      try {
        await operation.perform();
      } catch (error) {
        // 에러 처리, 재큐잉 가능
      }
    }
  }
}

class SyncOperation {
  // 작업 세부 정보 정의
  Future<void> perform() async {
    // 작업 구현
  }
}

main() {
  // 사용 예시
  final syncQueue = SyncQueue();
  final syncManager = SyncManager(syncQueue);

  // 큐에 작업 추가
  // syncQueue.addToQueue(/* SyncOperation 인스턴스 */);
}
