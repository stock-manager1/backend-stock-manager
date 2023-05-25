import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../dto/login_request.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserController {
  UserService userService = UserService();

  Future<Response> findById(Request req, String id) async {
    try {
      User user = await userService.userFind("id", id);
      if (!user.isEmpty()) {
        return Response.ok(
            jsonEncode({
              'user': user.toMap(),
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      } else {
        return Response.ok(
            jsonEncode({
              'message': "Usuário não encontrado!",
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
            'message': 'Erro interno no servidor',
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    }
  }

  Future<Response> deleteById(Request req, String id) async {
    try {
      String message = await userService.delete(id);
      return Response.ok(
          jsonEncode({
            'message': message,
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
            'message': 'Erro interno no servidor',
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    }
  }

  Future<Response> login(Request req) async {
    try {
      final String body = await req.readAsString();
      final Map<String, dynamic> loginData = jsonDecode(body);
      final LoginRequest login = LoginRequest.fromMap(loginData);
      String token = await userService.login(login.email, login.password);
      return Response.ok(
          jsonEncode({
            'token': token,
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } on Exception catch (e) {
      return Response.notFound(
          jsonEncode({
            'message': '$e',
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
            'message': 'Erro interno no servidor',
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    }
  }
}
