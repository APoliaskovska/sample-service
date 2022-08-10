import 'dart:io';
import 'dart:convert';
import 'package:proto_sample/generated/sample.pb.dart';

final List<UserDetails> userDetailsDb = _readUserDb();

List _getUserDetails() {
  final jsonString = File('db/user_details_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

UserDetails? getUserDetails(int id) {
  return userDetailsDb.firstWhere((element) => element.id == id);
}

List<UserDetails> _readUserDb() => _getUserDetails()
    .map((entry) => UserDetails()
  ..id = entry['id']
  ..name = entry['name']
  ..surname = entry['surname']
  ..dateBirth = entry['date_birth']).toList();
