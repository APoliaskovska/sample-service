import 'package:grpc/src/server/call.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:sample_service/cards_db_driver.dart';
import 'package:grpc/grpc.dart' as grpc;


class SampleService extends SampleServiceBase {
  @override
  Future<Cards> getCards(ServiceCall call, User request) async {
    print('Get cards request from user: $request');
    return Cards(id: 1, cards: cardsDb);
  }

  @override
  Future<UserDetails> getUserDetails(ServiceCall call, User request) {
    // TODO: implement getUserDetails
    throw UnimplementedError();
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