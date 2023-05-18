import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../src/controllers/user_controller.dart';
import '../src/services/user_service.dart';


// Configure routes.
final _router = Router();

void main(List<String> args) async {
  UserService userService = UserService();
  UserController userController = UserController(userService);

  _router.get('/users', userController.getAllUsers);
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = "localhost";

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '3000');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
