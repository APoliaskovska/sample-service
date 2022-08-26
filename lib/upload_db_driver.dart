import 'dart:math';

import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample_service/models/docs_model.dart';
import 'package:sample_service/services/sqlite_service.dart';

Future<List> _getDocs() async {
  final db = await SqliteService.initDb();

  List<Map> list = await db.rawQuery('SELECT * FROM DocModel');
  List<DocModel> docs = [];
  for (int i = 0; i < list.length; i++) {
    docs.add(DocModel(id: list[i]["id"], title: list[i]["title"], doc: list[i]["doc"], docType: list[i]["docType"], laptopId: list[i]["laptopId"]));
  }
  return docs;
}

Future<int> addDocInDB(UploadDocRequest requestData) async {
  final db = await SqliteService.initDb();
  final model = DocModel.fromUploadRequest(requestData);
  await SqliteService.insertDoc(db, model);
  return model.id;
}
