import 'dart:io';
import 'dart:convert';
import 'package:proto_sample/generated/sample.pb.dart';

final List<User> usersDb = _readUsersDb();

List _getUsers() {
  final jsonString = File('db/users_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

User? getUser(String login) {
  return usersDb.firstWhere((element) => element.login == login);
}

List<User> _readUsersDb() => _getUsers()
    .map((entry) => User()
  ..id = entry['id']
  ..login = entry['login']
  ..token = entry['token']).toList();
