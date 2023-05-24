import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

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
}
