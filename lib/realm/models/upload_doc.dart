import 'dart:typed_data';

import 'package:realm/realm.dart';
part 'upload_doc.g.dart';

@RealmModel()
class _UploadDoc {
  @PrimaryKey()
  late String title;
  late String? docType;
  late String? laptopId;
  late List<int> file;
}
