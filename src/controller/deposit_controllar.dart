import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../models/deposit.dart';
import '../services/deposit_service.dart';

class DepositController {
  final _depositService = DepositService();

  // Registrar Deposito:
  Future<Response> register(Request request) async {
    try {
      String message = await _depositService.depositRegister(request);
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
            'error': e,
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    }
  }

  // Listar Deposits:
  Future<Response> getAllDeposits(Request request) async {
    try {
      final List<Deposit> listAllDeposits =
          await _depositService.listAllDeposits();

      return Response.ok(
          jsonEncode({
            'deposits':
                listAllDeposits.map((deposit) => deposit.toMap()).toList()
          }),
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

  // Encontrar Deposito:
  Future<Response> findDepositById(Request req, String id) async {
    try {
      Deposit deposit = await _depositService.depositFind("id", id);

      if (!deposit.isEmpty()) {
        return Response.ok(
            jsonEncode({
              'deposit': deposit.toMap(),
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      } else {
        return Response.ok(
            jsonEncode({
              'message': "Deposito não encontrado!",
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

  // Alterar Deposito:
  Future<Response> updateDeposit(
      Request request, String id, String key, String value) async {
    try {
      bool update = await _depositService.updateDeposit(id, key, value);
      if (update == true) {
        return Response.ok(
            jsonEncode({'message': "$key alterado com Sucesso."}),
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

  // Deletar Produto:
  Future<Response> deleteById(Request req, String id) async {
    try {
      String message = await _depositService.depositDelete(id);
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
