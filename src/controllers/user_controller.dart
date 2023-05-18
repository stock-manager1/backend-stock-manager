// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UserController {
  final UserService _userService;

  UserController(this._userService);

  FutureOr<Response> getAllUsers(Request request) async {

    try {
      final List<User> allUsers = await _userService.findAllUsers();

      return Response.ok(
        jsonEncode({
          'user': allUsers.map((user) => user.toMap()).toList(),
        }),
        headers:  {
          HttpHeaders.contentTypeHeader: 'application/json'
        });

    } catch (e) {
      return Response.internalServerError(body: 'Erro ao buscar os usuários.');
    }
  }
}
