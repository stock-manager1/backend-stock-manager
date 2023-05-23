
import 'package:shelf/shelf.dart';


import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductService {
  
  final _productRepository = ProductsRepository();

  // Registrar Produto:
  Future<void> productRegister(Request request) async {
      final productRq = Product.fromJson(await request.readAsString());
      await _productRepository.productRegister(productRq);
  }

  // Encontrar Produto:
  Future<Product> productFind(String key, String value) async {
    Product product = await _productRepository.productFind(key, value);
    return product;
  }

  // Listar Produtos:
  Future<List<Product>> listAllProducts() async {
    List<Product> allProducts = await _productRepository.listAllProducts();
    
    return allProducts;
  }

  // Deletar produto:
  Future<String> productDelete(String id) async {
    try {
      return await _productRepository.productDelete(id);
    } catch (e) {
      return e.toString();
    }
  }

}