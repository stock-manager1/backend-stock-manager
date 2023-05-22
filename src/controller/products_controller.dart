import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../services/product_service.dart';

class ProductController {
  final _productService = ProductService();

  Future<Response> register(Request request) async {

      try {
       await _productService.productRegister(request);
       return Response.ok(jsonEncode({
              'message': "Produto registrado com sucesso!",
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            'error': 'Produto já cadastrado.',
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
      }
  }
}