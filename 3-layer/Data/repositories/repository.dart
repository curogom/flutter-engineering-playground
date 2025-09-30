import 'dart:convert';

import '../data_sources/remote.dart';
import '../models/model.dart';

class DataRepository {
  // 데이터 소스를 위한 플레이스홀더, 예: 데이터베이스 또는 네트워크 API
  DataRepository(this.remote);

  final RemoteService remote;

  Future<List<UserModel>> fetchData() async {
    final data = await remote.getRemoteData();
    final json = jsonDecode(data) as List<dynamic>;
    return json.map((e) => UserModel.fromJson(e)).toList();
  }
}
