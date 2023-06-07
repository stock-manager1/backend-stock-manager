import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../dto/custom_product_names_deposit_response.dart';
import '../dto/custom_product_response.dart';
import '../services/product_service.dart';

class ProductController {
  final _productService = ProductService();

  // Registrar Protudo:
  Future<Response> register(Request product) async {
    try {
      bool request = await _productService.productRegister(product);
      if (request == true) {
        return Response.ok(
            jsonEncode({
              'message': "Produto Cadastrado.",
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      } else {
        return Response.ok(
            jsonEncode({
              'message': "Produto já existe",
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
            'error': e.toString(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    }
  }

  // Encontrar Produto:
  Future<Response> findProductById(Request req, String id) async {
    try {
      CustomProductNamesDespositResponse product =
          await _productService.productFind("id", id);
      if (!product.isEmpty()) {
        return Response.ok(
            jsonEncode({
              'product': product.toMap(),
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      } else {
        return Response.ok(
            jsonEncode({
              'message': "Produto não encontrado!",
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

  // Listar Produtos:
  Future<Response> getAllProducts(Request request) async {
    try {
      final List<CustomProductResponse> listProducts =
          await _productService.listAllProducts();

      return Response.ok(
          jsonEncode({
            'products': listProducts.map((product) => product.toMap()).toList()
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

  // Alterar Produto:
  Future<Response> updateProduct(
      Request request, String id, String key, String value) async {
    try {
      bool update = await _productService.updateProduct(id, key, value);
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
      bool delete = await _productService.productDelete(id);
      if (delete == true) {
        return Response.ok(
            jsonEncode({
              'message': "Produto Deletado com Sucesso.",
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      } else {
        return Response.ok(
            jsonEncode({
              'message': "Produto não existe.",
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
}
