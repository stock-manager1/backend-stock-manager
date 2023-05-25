import 'package:mysql1/mysql1.dart';
import 'package:test/test.dart';

import '../../bin/core/database/database.dart';
import '../models/user.dart';

class UserRepository {
  Database db = Database();

  Future<User> find(String key, String value) async {
    try {
      MySqlConnection conn = await db.connectToDatabase();
      Results userFind =
          await conn.query('select * from users where $key = ?', [value]);
      User user = User();
      if (userFind.isNotEmpty) {
        user = User.fromMap(userFind.first.fields);
      }

      conn.close();
      return user;
    } catch (e) {
      print(e);
      return User();
    }
  }

  Future<String> delete(String id) async {
    try {
      MySqlConnection conn = await db.connectToDatabase();
      Results result = await conn.query('delete from users where id = ?', [id]);
      conn.close();
      if (result.affectedRows! > 0) {
        return 'Deletado com sucesso!';
      } else {
        return 'Nenhum usuário encontrado!';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
