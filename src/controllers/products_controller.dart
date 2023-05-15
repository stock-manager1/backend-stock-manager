import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../data/fake_data.dart';
import '../dto/produtc_dto.dart';
import '../models/product_model.dart';
import '../services/produtcs_service.dart';

class ProdutcsController {
  final ProductsService _productsService;
  ProdutcsController(this._productsService);

  FutureOr<Response> getAll(Request request) async {
    try {
      final List<ProductModel> all = await _productsService.findAll();
      return Response.ok(
          jsonEncode({
            'products': all.map((product) => product.toMap()).toList(),
          }),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'error': e.toString()}));
    }
  }

  FutureOr<Response> getById(Request request, String id) async {
    final int produtctId = int.parse(id);
    try {
      final ProductModel product = await _productsService.findById(produtctId);
      return Response.ok(
          jsonEncode({
            'product': product.toMap(),
          }),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'erro': e.toString()}));
    }
  }

  FutureOr<Response> create(Request request) async {
    final String body = await request.readAsString();
    final Map<String, dynamic> productData = jsonDecode(body);
    final ProductDTO newProductDTO = ProductDTO.fromMap(productData);

    try {
      final ProductModel newProduct =
          await _productsService.create(newProductDTO);
      return Response(201,
          body: jsonEncode({
            'product': newProduct.toMap(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({
            'error': e.toString(),
          }),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    }
  }
}
