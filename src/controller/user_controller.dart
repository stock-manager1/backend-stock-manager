import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../dto/login_request.dart';
import '../dto/register_request.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserController {
  UserService userService = UserService();

  //Registrar Usuário:
  Future<Response> register(Request req) async {
    try {
      final String body = await req.readAsString();
      final Map<String, dynamic> registerData = jsonDecode(body);
      final RegisterRequest register = RegisterRequest.fromMap(registerData);
      await userService.register(
          register.email, register.password, register.name);
      return Response.ok(
          jsonEncode({
            'message': "Cadastro com Sucesso!",
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

  //Login Usuário:
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

  //Encontrar Usuário:
  Future<Response> findById(Request req, String id) async {
    try {
      User user = await userService.find("id", id);
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

  //Listar Usuário:
  Future<Response> getAllUser(Request request) async {
    try {
      final List<User> listUser = await userService.listAllUser();

      return Response.ok(
          jsonEncode(
              {'users': listUser.map((Product) => Product.toMap()).toList()}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
            'message': e.toString(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    }
  }

  //Alterar Usuário:
  Future<Response> updateUser(Request request, String id, String email,
      String key, String value) async {
    try {
      bool update = await userService.updateUser(id, email, key, value);
      if (update == true) {
        return Response.ok(
            jsonEncode({'message': "$key alterado com sucesso."}),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      } else {
        return Response.ok(
            jsonEncode({
              'message': "$key não pode ser alterado ou não existe.",
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
            'message': e.toString(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    }
  }

  //Deletar Usuário:
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
