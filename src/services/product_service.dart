import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import '../dto/custom_product_names_deposit_response.dart';
import '../dto/custom_product_response.dart';
import '../models/amout_products.dart';
import '../models/deposit.dart';
import '../models/product.dart';
import '../repositories/amount_products_repository.dart';
import '../repositories/deposit_repository.dart';
import '../repositories/product_repository.dart';

class ProductService {
  final _productRepository = ProductsRepository();
  final _amountRepository = AmountProductRepository();
  final _depositRepository = DepositRepository();

  // Registrar Produto:
  Future<bool> productRegister(Request product) async {
    bool registerSucess = false;
    final productRq = CustomProductResponse.fromJson(await product.readAsString());
    Results result = await _productRepository.productAlreadyExist(productRq);

    if (result.isEmpty) {
      registerSucess = true;
      final product = await _productRepository.productRegister(productRq);
      await _amountRepository.register(product.id, productRq.amount);
    }

    return registerSucess;
  }

  // Encontrar Produto:
  Future<CustomProductNamesDespositResponse> productFind(
      String key, String value) async {
    Product product = await _productRepository.productFind(key, value);

    List<AmountProduct> listAmount =
        await _amountRepository.listById(product.id);

    List<DepositProduct> depositos = List.empty(growable: true);
    for (AmountProduct amount in listAmount) {
      Deposit deposit = await _depositRepository.depositFind(
          "id", amount.idDeposit.toString());
      depositos.add(DepositProduct(name: deposit.name, amount: amount.amount));
    }
    CustomProductNamesDespositResponse productResponse =
        CustomProductNamesDespositResponse(
            product.id, product.name, product.brand, product.type, depositos);

    return productResponse;
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
          product.id, product.name, product.brand, product.type, amount);
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
      await _amountRepository.productDelete(id);
      await _productRepository.productDelete(id);
      
      sucess = true;
    }

    return sucess;
  }
}
