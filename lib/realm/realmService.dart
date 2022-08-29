import 'dart:typed_data';

import 'package:realm/realm.dart';
import 'models/upload_doc.dart';

class RealmService {
  static RealmService? _instance;

  late Configuration config;
  late Realm realm;

  RealmService._() {
    config = Configuration.local([UploadDoc.schema], schemaVersion: 2);
    realm = Realm(config);
  }

  factory RealmService() {
    _instance ??= RealmService._();
    return _instance!;
  }

  RealmResults<UploadDoc> getAllDocs() {
    return realm.all<UploadDoc>();
  }

  dynamic insertDoc(String title, List<int> fileData, String docType, String uuid) {
    final doc = UploadDoc(
      title,
      docType: docType,
      laptopId: uuid,
      file: fileData,
    );
    try {
      realm.write(() {
        realm.add(doc);
      });
     // realm.close();
    } catch (error) {
      return error;
    }

    final sortedDocs = realm.all<UploadDoc>().query('title == "$title"').isNotEmpty;
    realm.close();
    return sortedDocs;
  }
}
