import 'dart:io';

import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'core/database/database.dart';

// Configure routes.
final _router = Router();

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = "localhost";

  Database database = Database();

  MySqlConnection conn = await database.connectToDatabase();

  Results result = await conn.query('SELECT * FROM users');

  for (var row in result) {
    print('ID: ${row[0]}, Name: ${row[1]}');
  }

  // Feche a conexão
  await conn.close();
  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '3000');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
