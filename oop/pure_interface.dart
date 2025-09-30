// 데이터 가져오기 서비스를 위한 순수 인터페이스
abstract interface class DataService {
  Future<String> fetchData();
}

// 네트워크 API에서 데이터를 가져오는 DataService 구현
class NetworkDataService implements DataService {
  @override
  Future<String> fetchData() async {
    // 여기에 네트워크 요청 로직 구현
    return 'Data from network';
  }
}

// 모의 데이터를 가져오는 DataService 구현 (테스트에 유용함)
class MockDataService implements DataService {
  @override
  Future<String> fetchData() async {
    return 'Mock data';
  }
}

// 로컬 데이터베이스에서 데이터를 가져오는 DataService 구현
class LocalDatabaseService implements DataService {
  @override
  Future<String> fetchData() async {
    // 여기에 로컬 데이터베이스 접근 로직 구현
    return 'Data from local database';
  }
}
