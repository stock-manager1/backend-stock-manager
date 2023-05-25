import 'dart:io';

import 'package:mysql1/mysql1.dart';
import 'package:test/test.dart';

import '../../bin/core/database/database.dart';
import '../models/user.dart';

class UserRepository {
  Database db = Database();

  // Registrar Usuário:
  Future<void> userRegister(User user) async {
    MySqlConnection conn = await db.connectToDatabase();
    try {
      final isUserRegistered = await conn.query('''
        select * from users 
        where id = ?
        and name = ?
        and email = ?
        ''', [user.id, user.name, user.email]);

      if (isUserRegistered.isEmpty) {
        await conn.query('''
          insert into users
          values (?,?,?,?)
          ''', [null, user.id, user.name, user.email]);
      } else {
        print('Usuário já cadastrado');
      }
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception('Usuário já Cadastrado.');
    } finally {
      await conn.close();
    }
  }

  // Listar Usuário:

  Future<List<User>> listAllUserr() async {
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
  Future<User> userFind(String key, String value) async {
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

  //Alterar Usuário:
  Future<bool> userUpdate(
      String id, String email, String key, String value) async {
    User user = await userFind("id", id);
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
