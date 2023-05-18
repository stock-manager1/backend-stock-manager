import 'package:backend/manegement/data/data_deposito_constant.dart';
import 'package:backend/manegement/data/data_inventario_constant.dart';
import 'package:backend/manegement/data/data_produto_constant.dart';
import 'package:backend/manegement/data/data_qntd_constant.dart';
import 'package:backend/manegement/data/data_transferir_constant.dart';
import 'package:backend/manegement/data/data_usuario_constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static late Database _db;

  static Future<Database> get() async {
    if (_db == null) {
      var path = join(await getDatabasesPath(), 'banco_stockManager');
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, v) {
          db.execute(createDepositoTable);
          db.execute(createInventarioTable);
          db.execute(createProdutoTable);
          db.execute(createQntdTable);
          db.execute(createTransferirTable);
          db.execute(createUserTable);
        },
      );
    }
    return _db;
  }
}
