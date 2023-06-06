import 'package:mysql1/mysql1.dart';
import '../../bin/core/database/database.dart';
import '../models/product.dart';

class TransferProduct {
  Database db = Database();

  // ignore: non_constant_identifier_names
  ProductTransfer(Product product) async {
    MySqlConnection conn = await db.connectToDatabase();
    try {
      final isTransferProduct = await conn.query('''
        change * from products 
        where name = ?
        and brand = ?
        and type = ?
        ''', [product.name, product.brand, product.type]);
      // ignore: unnecessary_null_comparison
      if (isTransferProduct.isEmpty) {
        await conn.query('''
        change * from products 
        where name = ?
        and brand = ?
        and type = ?
        ''', [product.name, product.brand, product.type]);
      } else {
        print('Produto Inexistente');
      }
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception('Produto já está Presente');
    } finally {
      await conn.close();
    }
  }
}
