import 'package:mysql1/mysql1.dart';

import '../../bin/core/database/database.dart';
import '../models/user.dart';

class UserRepository {
  Database db = Database();

  // Registrar Usuário:
  Future<void> userRegister(User user) async {
    try {
      MySqlConnection conn = await db.connectToDatabase();
      await conn.query('''
      INSERT INTO users (email, password, name)
      VALUES (?, ?, ?)
    ''', [user.email, user.password, user.name]);
      conn.close();
    } catch (e) {
      throw Exception("Erro no servidor");
    }
  }

  // Listar Usuário:
  Future<List<User>> listAllUser() async {
    MySqlConnection conn = await db.connectToDatabase();
    Results users = await conn.query('select * from users');

    List<User> allUsers = List.empty(growable: true);

    for (ResultRow result in users) {
      User user = User.fromMap(result.fields);
      allUsers.add(user);
    }

    conn.close();
    return allUsers;
  }

  // Encontrar Usuário:
  Future<User> find(String key, String value) async {
    MySqlConnection conn = await db.connectToDatabase();
    Results userFind =
        await conn.query('select * from users where $key = ?', [value]);
    User user = User();
    if (userFind.isNotEmpty) {
      user = User.fromMap(userFind.first.fields);
    }
    conn.close();
    return user;
  }

  //Alterar Usuário:
  Future<bool> userUpdate(
      String id, String email, String key, String value) async {
    User user = await find("id", id);
    bool sucess = false;

    if (!user.isEmpty()) {
      MySqlConnection conn = await db.connectToDatabase();
      await conn
          .query("Update user set $key = ? where id = ${user.id}", [value]);

      conn.close();
      sucess = true;
    }
    return sucess;
  }

  // Deletar Usuário:
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
