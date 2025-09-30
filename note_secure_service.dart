import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureDataService {
  final flutterSecureStorage = const FlutterSecureStorage();

  // 1. 비밀번호로부터 키 파생
  Future<encrypt.Key> deriveKey(
    String password,
    List<int> salt,
  ) async {
    // Argon2id는 사이드 채널 공격에 저항성이 있는
    // 비밀번호 해싱 알고리즘입니다
    final algorithm = Argon2id(
      parallelism: 4,
      memory: 10000, // 10 MB
      iterations: 3,
      hashLength: 32,
    );

    // 비밀번호로부터 키 파생
    final secretKey = await algorithm.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      // 키를 고유하게 만들기 위해 무작위 바이트인 salt 사용
      nonce: salt,
    );

    final secretKeyBytes = await secretKey.extractBytes();
    // 키를 바이트 리스트로 가져오기
    return encrypt.Key(
      Uint8List.fromList(secretKeyBytes),
    );
  }

  // 2. 나중에 사용하기 위해 보안 저장소에 키 저장
  Future<void> storeSecretKey(encrypt.Key key, String keyName) async {
    await flutterSecureStorage.write(
      key: keyName,
      value: base64Encode(key.bytes),
    );
  }

  // 3. 필요할 때 보안 저장소에서 키 검색
  Future<encrypt.Key?> getSecretKey(String keyName) async {
    final keyString = await flutterSecureStorage.read(key: keyName);
    if (keyString == null) return null;
    return encrypt.Key(
      base64Decode(keyString),
    );
  }

  // 4. 무작위 salt 생성
  List<int> generateSalt() {
    return encrypt.SecureRandom(16).bytes;
  }

  //5. 파생한 키를 사용하여 데이터 암호화 및 복호화
  Future<String> encryptData(String data, encrypt.Key key) async {
    // IV는 초기화 벡터를 나타냅니다
    final iv = encrypt.IV.fromLength(16);
    // Encrypter는 고유한 컨테이너에 encrypt.Algorithm을 래핑합니다
    // AES는 암호화와 복호화에 동일한 키를 사용하는
    // 대칭 암호화 알고리즘입니다
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key),
    );

    // 주어진 키와 IV로 AES를 사용하여 데이터 암호화
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  // 6. 파생한 키를 사용하여 데이터 복호화
  Future<String> decryptData(String encryptedData, encrypt.Key key) async {
    final iv = encrypt.IV.fromLength(16);
    // Encrypter는 고유한 컨테이너에 encrypt.Algorithm을 래핑합니다
    final encrypter = encrypt.Encrypter(
      // 암호화에 사용된 것과 동일한 알고리즘 및 키
      encrypt.AES(key),
    );

    // 주어진 키와 IV로 AES를 사용하여 데이터 복호화
    return encrypter.decrypt64(encryptedData, iv: iv);
  }
}

void main() async {
  // ----------------------------------------
  final secureDataService = SecureDataService();
  // 사용자가 비밀번호를 제공한다고 상상해보세요
  const password = 'userPassword';
  // 무작위 salt를 생성하기 위해 이것을 구현하세요
  final salt = secureDataService.generateSalt();

  // 키 파생 및 저장
  final key = await secureDataService.deriveKey(password, salt);
  await secureDataService.storeSecretKey(key, 'myEncryptionKey');
  // ----------------------------------------

  // ----------------------------------------
  // 데이터 암호화
  final encryptedData =
      await secureDataService.encryptData('Sensitive data', key);

  // 데이터 복호화
  final decryptedData = await secureDataService.decryptData(encryptedData, key);

  print('Encrypted Data: $encryptedData');
  print('Decrypted Data: $decryptedData');
  // ----------------------------------------
}
