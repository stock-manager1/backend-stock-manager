import 'package:shelf/shelf.dart';

import '../dto/produtc_dto.dart';
import '../models/amout_products.dart';
import '../models/product.dart';
import '../repositories/amount_products_repository.dart';
import '../repositories/product_repository.dart';

class ProductService {
  final _productRepository = ProductsRepository();
  final _amountRepository = AmountProductRepository();

  // Registrar Produto:
  Future<bool> productRegister(Request product) async {
    final productRq = Product.fromJson(await product.readAsString());
    bool productSucess = await _productRepository.productRegister(productRq);

    return productSucess;
  }

  // Encontrar Produto:
  Future<Product> productFind(String key, String value) async {
    Product product = await _productRepository.productFind(key, value);
    return product;
  }

  // Listar Produtos:
  Future<List<CustomProductResponse>> listAllProducts() async {
    List<Product> allProducts = await _productRepository.listAllProducts();
    List<CustomProductResponse> productResponse = List.empty(growable: true);
    late List<AmountProduct> listAmount;

    for (Product product in allProducts) {
      listAmount = await _amountRepository.listById(product.id);
      int amount = 0;

      for (AmountProduct list in listAmount) {
        amount += list.amount;
      }
      CustomProductResponse custom = CustomProductResponse(
          amount, product.id, product.name, product.brand, product.type);
      productResponse.add(custom);
    }

    return productResponse;
  }

  // Alterar Produto:
  Future<bool> updateProduct(String id, String key, String value) async {
    bool sucess = false;
    Product product = await productFind("id", id);

    if (key == "name" ||
        key == "brand" ||
        key == "type" && !product.isEmpty()) {
      await _productRepository.productUpdate(product.id, key, value);
      sucess = true;
    }

    return sucess;
  }

  // Deletar produto:
  Future<bool> productDelete(String id) async {
    bool sucess = false;
    Product product = await productFind("id", id);

    if (!product.isEmpty()) {
      await _productRepository.productDelete(id);
      sucess = true;
    }

    return sucess;
  }
}
