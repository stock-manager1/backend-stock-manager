import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../src/controller/products_controller.dart';
import '../src/controller/user_controller.dart';

// Configure routes.
final _router = Router();
UserController userController = UserController();
ProductController productController = ProductController();

void main(List<String> args) async {
  //UserController:
  _router.get("/user/<id>", userController.findById);
  _router.delete("/user/<id>", userController.deleteById);

  //ProductController:
  _router.post("/registerproduct", productController.register);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = "localhost";
  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
