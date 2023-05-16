import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:backend/core/data/data_general_constants.dart';
import 'package:backend/manegement/data/data_deposito_constant.dart';
import 'package:backend/manegement/data/data_inventario_constant.dart';
import 'package:backend/manegement/data/data_produto_constant.dart';
import 'package:backend/manegement/data/data_qntd_constant.dart';
import 'package:backend/manegement/data/data_transferir_constant.dart';
import 'package:backend/manegement/data/data_usuario_constant.dart';

class Manegementesqflitesource {
  Future<Database> _getDatabase() async {
    /* await deleteDatabase(
      join(await getDatabasesPath(), dataBaseName)  
    ); */
   
    return openDatabase(
      join(await getDatabasesPath(), dataBaseName),
      onCreate: (db, version) async {
        await db.execute(createUserTable);
        await db.execute(createDepositoTable);
        await db.execute(createInventarioTable);
        await db.execute(createProdutoTable);
        await db.execute(createQntdTable);
        await db.execute(createTransferirTable);

        await db.rawInsert('''
          INSERT INTO $userTableName($userColumnid, $userColumnLogin, $userColumnSenha)
          VALUES (null, 'adm', 'adm')
        ''');
      },
      version: dataBaseVersion
    );
  }
}