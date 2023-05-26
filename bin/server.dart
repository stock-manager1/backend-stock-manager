import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../src/controller/deposit_controllar.dart';
import '../src/controller/products_controller.dart';
import '../src/controller/user_controller.dart';

// Configure routes.
final _router = Router();
final _userController = UserController();
final _productController = ProductController();
final _depositController = DepositController();

void main(List<String> args) async {
  DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
  //UserCrud:
  _router.get("/user/<id>", _userController.findById);
  _router.delete("/user/<id>", _userController.deleteById);
  _router.post("/user/login", _userController.login);

  //ProductCrud:
  _router.post("/registerproduct", _productController.register);
  _router.get("/listproducts", _productController.getAllProducts);
  _router.get("/product/<id>", _productController.findProductById);
  _router.put("/updateproduct/<id>/<key>/<value>", _productController.updateProduct);
  _router.delete("/deleteproduct/<id>", _productController.deleteById);

  //DepositCrud:
  _router.post("/registerdeposit", _depositController.register);
  _router.get("/listdeposits", _depositController.getAllDeposits);
  _router.get("/deposit/<id>", _depositController.findDepositById);
  _router.put("/updatedeposit/<id>/<key>/<value>", _depositController.updateDeposit);
  _router.delete("/deletedeposit/<id>", _depositController.deleteById);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = "localhost";
  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port =
      int.parse(Platform.environment['PORT'] ?? env["SERVER_PORT"].toString());
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
