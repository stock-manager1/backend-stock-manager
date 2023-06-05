import 'package:mysql1/mysql1.dart';

import '../../bin/core/database/database.dart';
import '../models/amout_products.dart';

class AmountProductRepository {
  Database db = Database();

  // Registrar Quantidade de Produtos
  Future<void> register(String productId, String depositId, String amount) async {
    MySqlConnection conn = await db.connectToDatabase();

    await conn.query('''
          insert into amount_product
          values (?,?,?)
          ''', [productId, depositId, amount]);

    conn.close();
  }

  // Listar Quantidade de Produtos por id
  Future<List<AmountProduct>> listById(int productId) async {
    MySqlConnection conn = await db.connectToDatabase();

    List<AmountProduct> list = List.empty(growable: true);
    Results rows = await conn.query('select * from amount_product where id_product = ?', [productId]);

    for (ResultRow result in rows) {
      AmountProduct amount = AmountProduct.fromMap(result.fields);
      list.add(amount);
    }

    conn.close();
    return list;
  }
}
