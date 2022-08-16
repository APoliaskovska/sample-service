import 'dart:io';
import 'dart:convert';

import 'package:proto_sample/generated/sample.pb.dart';

final List<TransactionsList> transactionsDb = _readTransactionsDb();

List _getTransactionList() {
  final jsonString = File('db/transactions_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

TransactionsList? getCardTransactions(int cardId) {
  print("cardId = " + cardId.toString());
  return transactionsDb.firstWhere((element) => element.cardId == cardId);
}

List<TransactionsList> _readTransactionsDb() {
  return _getTransactionList()
      .map((entry) {

        List<Transaction> transactions = [];
         (entry['transactions_list'] as List<dynamic>).forEach((element) {
           transactions.add(
               Transaction(
                 id: element['id'],
                 date: element['date'],
                 status: element['status'],
                 referenceNumber: element['reference_number'],
                 fee: element['fee'],
                 amount: element['amount'],
                 currency: element['currency'],
                 details: element['details'],
                 accountNumber: element['account_number'],
                 type: element['type']
               )
           );
         });

        return TransactionsList(
            cardId: entry['card_id'],
            transactionsList: transactions);
      }).toList();
}
