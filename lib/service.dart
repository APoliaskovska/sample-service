import 'dart:io';

import 'package:grpc/src/server/call.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:sample_service/cards_db_driver.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:sample_service/user_details_driver.dart';

class SampleService extends SampleServiceBase {
  @override
  Future<Cards> getCards(ServiceCall call, User request) async {
    print('Received question request from: $request');
    return Cards(id: request.id, cards: cardsDb);
  }

  @override
  Future<UserDetails> getUserDetails(ServiceCall call, User request) async {
    return userDetailsDb.firstWhere((element) => element.id == request.id);
  }

  @override
  Future<AvatarImage> getUserAvatar(ServiceCall call, User request) async {
    final imageFile = File('db/images/avatar1.png').readAsBytes();
    return AvatarImage(image: await imageFile);
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