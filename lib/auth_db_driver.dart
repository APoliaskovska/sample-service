import 'dart:io';
import 'dart:convert';
import 'package:proto_sample/generated/sample.pb.dart';

final List<AuthRequest> authDb = _readAuthDb();

List _getAuth() {
  final jsonString = File('db/auth_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

AuthRequest? getAuthParams(String login, String password) {
  return authDb.firstWhere((element) => element.login == login && element.password == password);
}

List<AuthRequest> _readAuthDb() => _getAuth()
    .map((entry) => AuthRequest()
  ..login = entry['login']
  ..password = entry['password']
  ..system = entry['system']
  ..deviceId = entry['deviceId']).toList();
