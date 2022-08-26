import 'dart:math';
import 'dart:typed_data';

import 'package:proto_sample/generated/sample.pb.dart';

class DocModel {
  late final int id;
  late final String title;
  late final String docType;
  late final String laptopId;
  late final Uint8List doc;

  DocModel({
    required this.id,
    required this.title,
    required this.doc,
    required this.docType,
    required this.laptopId});

  DocModel.fromUploadRequest(UploadDocRequest request) {
    final rid = Random().nextInt(100000);

    id = rid;
    title = "Doc_" + rid.toString();
    doc = Uint8List.fromList(request.chunkData);
    docType = request.info.docType;
    laptopId = request.info.laptopId;
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "doc" : doc,
  };
}