import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:proto_sample/generated/sample.pb.dart';

final List<FileFolder> foldersDb = _readFoldersDb();
final List<FileObject> filesDb = _readFilesDb();

List _getFolders() {
  final jsonString = File('db/folders_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

List _getFiles() {
  final jsonString = File('db/files_db.json').readAsStringSync();
  return jsonDecode(jsonString);
}

List<FileFolder>? getFolders(){
  return _readFoldersDb();
}

List<FileObject>? getFilesFromFolderId(String folderId) {
  List<FileFolder> folders = foldersDb.where((element) => element.id == folderId).toList();
  if (folders.isEmpty) { return []; }

  List<int> ids = folders.first.filesIds;

  return filesDb.where((element) {
    return ids.contains(int.parse(element.id));
  }).toList();
}

Future<FileData> getFileFromFileId(String fileId) async {
  FileObject? file = filesDb.firstWhere((element) => element.id == fileId);
  if (file == null) { return FileData(); }
  File fileData = await _downloadFile(file.url, ("${file.name}.${file.format}"));
  return FileData(id: fileId, format: file.format, data: fileData.readAsBytesSync());
}

Future<File> _downloadFile(String url, String filename) async {
  Response response = await get(Uri.parse(url));

  File file = File(filename);
  await file.writeAsBytes(response.bodyBytes);

  print("file size = " + file.lengthSync().toString());

  return file;
}

List<FileFolder> _readFoldersDb() {
  return _getFolders().map((entry) {
    List<dynamic> filesIds = entry["filesIds"] ?? [];
    return FileFolder(
        id: entry['id'],
        name: entry['name'],
        description: entry['description'],
        access: entry['access'],
        filesIds: filesIds.map((e) => int.parse(e.toString()))
    );
  }).toList();
}

List<FileObject> _readFilesDb() {
  return _getFiles()
      .map((entry) => FileObject()
    ..id = entry['id']
    ..name = entry['name']
    ..format = entry['format']
    ..url = entry['url']
    ..access = entry['access']
  ).toList();
}
