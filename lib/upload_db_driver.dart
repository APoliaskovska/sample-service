import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample_service/realm/realmService.dart';
//import 'package:sample_service/sqlite/realmService.dart';

//
// Future<List> _getDocs() async {
//   List<Map> list = await db.rawQuery('SELECT * FROM DocModel');
//   List<DocModel> docs = [];
//   for (int i = 0; i < list.length; i++) {
//     docs.add(DocModel(id: list[i]["id"], title: list[i]["title"], doc: list[i]["doc"], docType: list[i]["docType"], laptopId: list[i]["laptopId"]));
//   }
//   return docs;
// }

Future<FileUploadChunkResponse> addDocInDB(FileUploadChunkRequest requestData) async {
  try {
    bool success = RealmService().insertDoc(requestData.name, requestData.chunk, requestData.type, requestData.uuid);
    return FileUploadChunkResponse(info: UploadFileResponse(id: requestData.name));
  } catch (error) {
    return FileUploadChunkResponse();
  }
}
