import 'dart:async';

import 'package:mysql1/mysql1.dart';

import '../../bin/core/database/database.dart';
import '../../bin/core/exceptions/Product_Already_Registered.dart';
import '../models/product.dart';

class ProductsRepository {
  Database db = Database();

  //Registrar Produtos:
  Future<void> productRegister(Product product) async {
    MySqlConnection conn = await db.connectToDatabase();

    try {
      final isProductRegistered = await conn.query('''
        select * from products 
        where name = ?
        and brand = ?
        and type = ?
        ''', [product.name, product.brand, product.type]);

      if (isProductRegistered.isEmpty) {
        await conn.query('''
          insert into products
          values (?,?,?,?)
          ''', [null, product.name, product.brand, product.type]);
      } else {
        throw ProductAlreadyRegistered();
      }
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception('Produto já Cadastrado.');
    } finally {
      await conn.close();
    }
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
  Future<bool> productUpdate(String id, String key, String value) async {
    Product product = await productFind("id", id);
    bool sucess = false;

    if (!product.isEmpty()) {
      MySqlConnection conn = await db.connectToDatabase();
      await conn.query(
          "update products set $key = ? where id = ${product.id}", [value]);

      conn.close();
      sucess = true;
    }

    return sucess;
  }

  //Deletar Produto:
  Future<String> productDelete(String id) async {
    try {
      MySqlConnection conn = await db.connectToDatabase();
      Results result =
          await conn.query('delete from products where id = ?', [id]);
      conn.close();
      if (result.affectedRows! > 0) {
        return 'Deletado com sucesso!';
      } else {
        return 'Nenhum produto encontrado!';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
