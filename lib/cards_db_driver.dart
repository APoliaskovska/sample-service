import 'dart:io';
import 'dart:convert';
import 'package:proto_sample/generated/sample.pb.dart';

final List<PaymentCard> cardsDb = _readDb();

List _getCardsList() {
  final jsonString = File('db/cards_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

List<PaymentCard> getCardsList(int id) {
  return cardsDb.toList();
}

List<PaymentCard> _readDb() {
  final list = _getCardsList().first;
  print("object list" + list.toString());
  return _getCardsList()
    .map((entry) => PaymentCard()
  ..id = entry['id']
  ..bankName = entry['bank_name']
  ..cardType = CardType(id: entry['card_type']["id"], type: entry['card_type']["type"])
  ..cardNumber = entry['card_number']
  ..expires = entry['expires']
  ..holderName = entry['holder_name']
  ..cvv = entry['cvv']
  ).toList();
}
