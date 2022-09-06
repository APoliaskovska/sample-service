import 'dart:io';

import 'package:grpc/src/server/call.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:sample_service/auth_db_driver.dart';
import 'package:sample_service/cards_db_driver.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:sample_service/folder_files_db_driver.dart';
import 'package:sample_service/transaction_db_driver.dart';
import 'package:sample_service/upload_db_driver.dart';
import 'package:sample_service/user_details_driver.dart';
import 'package:sample_service/users_db.dart';

class SampleService extends SampleServiceBase {
  //MARK: - AUTH

  @override
  Future<User> loginWith(ServiceCall call, AuthRequest request) async {
    final auth = getAuthParams(request.login, request.password);
    if (auth == null) { return User(); }
    return getUser(auth.login) ?? User();
  }

  //MARK: - USER DATA

  @override
  Future<UserDetails> getUserDetails(ServiceCall call, User request) async {
    return userDetailsDb.firstWhere((element) => element.id == request.id);
  }

  @override
  Future<AvatarImage> getUserAvatar(ServiceCall call, User request) async {
    final imageFile = File('db/images/avatar1.png').readAsBytes();
    return AvatarImage(image: await imageFile);
  }

  //MARK: - CARDS

  @override
  Future<Cards> getCards(ServiceCall call, User request) async {
    print('Received question request from: $request');
    return Cards(id: request.id, cards: cardsDb);
  }

  //MARK: - TRANSACTIONS

  @override
  Future<TransactionsList> getTransactionsList(ServiceCall call, TransactionsListRequest request) async {
    return getCardTransactions(request.cardId) ?? TransactionsList();
  }

  //MARK: - UPLOAD

  @override
  Future<FileUploadChunkResponse> uploadFileChunk(ServiceCall call, FileUploadChunkRequest request) async {
   // RealmService().insertDoc(request.name, request.chunk, request.type, request.uuid);
    return addDocInDB(request);//await addDocInDB(request);
  }

  @override
  Stream<FileData> downloadFile(ServiceCall call, DownloadFileRequest request) {
    return getFileFromFileId(request.fileId).asStream();
  }

  //MARK: - FILE FOLDERS

  @override
  Future<FileFoldersResponse> getFileFolders(ServiceCall call, FileFoldersRequest request) async {
    List<FileFolder> folders = getFolders() ?? [];
    return FileFoldersResponse(userId: request.userId, folders: folders);
  }

  @override
  Future<FilesFromFoldersResponse> getFilesFromFolder(ServiceCall call, FilesFromFoldersRequest request) async {
    List<FileObject> files = getFilesFromFolderId(request.folderId) ?? [];
    return FilesFromFoldersResponse(userId: request.userId, files: files);
  }
}

class Server {
  Future<void> run() async {
    final server = grpc.Server([SampleService()]);
    await server.serve(port: 5555);
    print('Serving on the port: ${server.port}');
  }
}

Future<void> main() async {
  await Server().run();
}