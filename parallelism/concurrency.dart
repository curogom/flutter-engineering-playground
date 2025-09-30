import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

// 이미지 처리를 동기적으로 수행하는 함수의 예제
Future<Uint8List> processImage(File imageFile) async {
  // 이미지를 로드하는 비동기 작업
  Uint8List imageData = await imageFile.readAsBytes();

  // 동기 이미지 처리 (이 부분이 UI를 차단함)
  Uint8List processedImageData = _synchronousImageProcessing(imageData);

  return processedImageData;
}

Uint8List _synchronousImageProcessing(Uint8List imageData) {
  // 이 함수가 완료되는데 오래 걸린다고 상상해보세요
  // ... 이미지 처리 로직 ...
  return imageData; // 처리된 이미지 데이터
}

singleStream() {
  final StreamController<int> controller = StreamController<int>();

  // 단일 구독 스트림 생성
  final Stream<int> stream = controller.stream;

  // 스트림 구독
  stream.listen(
    (number) => print('Received number: $number'),
    onDone: () => print('Stream is closed.'),
    onError: (error) => print('Error: $error'),
  );

  // 스트림에 데이터 추가
  for (int i = 0; i < 3; i++) {
    controller.sink.add(i);
  }

  // 스트림 닫기
  controller.close();
}

broadcastStream() {
  final StreamController<int> controller = StreamController<int>.broadcast();

  // 브로드캐스트 스트림 생성
  final Stream<int> stream = controller.stream;

  // 첫 번째 구독자
  stream.listen(
    (number) => print('First subscriber received: $number'),
  );

  // 두 번째 구독자
  stream.listen(
    (number) => print('Second subscriber received: $number'),
  );

  // 스트림에 데이터 추가
  for (int i = 0; i < 3; i++) {
    controller.sink.add(i);
  }

  // 스트림 닫기
  controller.close();
}

void main() {
  singleStream();
  broadcastStream();
}
