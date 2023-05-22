
import 'package:shelf/shelf.dart';


import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductService {
  
  final _productRepository = ProductsRepository();

  Future<void> productRegister(Request request) async {
      final productRq = Product.fromJson(await request.readAsString());
      await _productRepository.productRegister(productRq);
  }

}