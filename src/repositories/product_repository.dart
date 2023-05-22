import 'dart:async';

import 'package:mysql1/mysql1.dart';

import '../../bin/core/database/database.dart';
import '../../bin/core/exceptions/Product_Already_Registered.dart';
import '../models/product.dart';

class ProductsRepository {
  Database db = Database();

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
      throw Exception('Produto já Cdastrado.');
    } finally {
      await conn.close();
    }
  }
}
