import 'dart:async';

import 'package:mysql1/mysql1.dart';

import '../../bin/core/database/database.dart';
import '../dto/custom_product_response.dart';
import '../models/product.dart';

class ProductsRepository {
  Database db = Database();

  // Registrar Produtos:
  Future<Product> productRegister(CustomProductResponse product) async {
    MySqlConnection conn = await db.connectToDatabase();

    await conn.query('''
      insert into products values (?,?,?,?);
      ''', [null, product.name, product.brand, product.type]);

    final result = await conn.query('''
      select * from products where id = last_insert_id();
    ''');
    final finalProduct = Product.fromMap(result.first.fields);
    
    await conn.close();
    return finalProduct;
  }

  Future<Results> productAlreadyExist(CustomProductResponse product) async {
    MySqlConnection conn = await db.connectToDatabase();

    final result = await conn.query('''
        select * from products 
        where name = ?
        and brand = ?
        and type = ?
        ''', [product.name, product.brand, product.type]);

    return result;
  }

  // Listar Produto:
  Future<List<Product>> listAllProducts() async {
    MySqlConnection conn = await db.connectToDatabase();
    Results products = await conn.query('select * from products');

    List<Product> allProducts = List.empty(growable: true);

    for (ResultRow result in products) {
      Product product = Product.fromMap(result.fields);
      allProducts.add(product);
    }

    conn.close();
    return allProducts;
  }

  // Encontrar Produto:
  Future<Product> productFind(String key, String value) async {
    MySqlConnection conn = await db.connectToDatabase();

    Results productFind =
        await conn.query('select * from products where $key = ?', [value]);
    Product product = Product();
    if (productFind.isNotEmpty) {
      product = Product.fromMap(productFind.first.fields);
    }

    conn.close();
    return product;
  }

  // Alterar Produto:
  Future<void> productUpdate(int id, String key, String value) async {
    MySqlConnection conn = await db.connectToDatabase();
    await conn.query("update products set $key = ? where id = $id", [value]);

    conn.close();
  }

  //Deletar Produto:
  Future<void> productDelete(String id) async {
    MySqlConnection conn = await db.connectToDatabase();
    await conn.query('delete from products where id = ?', [id]);

    conn.close();
  }
}
