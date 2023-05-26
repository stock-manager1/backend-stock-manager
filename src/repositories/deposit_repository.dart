
import 'package:mysql1/mysql1.dart';

import '../../bin/core/database/database.dart';
import '../models/deposit.dart';

class DepositRepository {
  Database db = Database();

  //Registrar Deposito:
  Future<void> depositRegister(Deposit deposit) async {
    MySqlConnection conn = await db.connectToDatabase();

    try {
      final depositRegistered = await conn.query('select * from deposit where id = ${deposit.id}');

      if (depositRegistered.isEmpty) {
        await conn.query('''
          insert into deposit
          values (?,?,?,?,?)
          ''', [deposit.id, deposit.capacity, deposit.amount, deposit.address, deposit.name]);
      } else {
        throw Exception();
      }
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception('Deposito já Cadastrado.');

    } finally {
      await conn.close();
    }
  }

  // Listar Depositos:
  Future<List<Deposit>> listAllDeposits() async {
    MySqlConnection conn = await db.connectToDatabase();
    Results deposits = await conn.query('select * from deposit');

    List<Deposit> allDeposits = List.empty(growable: true);

    for (ResultRow result in deposits) {
      Deposit deposit = Deposit.fromMap(result.fields);
      allDeposits.add(deposit);
    }

    conn.close();
    return allDeposits;
  }

  // Encontrar Deposito:
  Future<Deposit> depositFind(String key, String value) async {
    MySqlConnection conn = await db.connectToDatabase();
    Results depositFind = await conn.query('select * from deposit where $key = ?', [value]);
    Deposit deposit = Deposit();

    if (depositFind.isNotEmpty) {
      deposit = Deposit.fromMap(depositFind.first.fields);
    }

    conn.close();
    return deposit;
  }

  // Alterar Produto:
  Future<bool> depositUpdate(String id, String key, String value) async {
    Deposit deposit = await depositFind("id", id);
    bool sucess = false;

    if (!deposit.isEmpty()) {
      MySqlConnection conn = await db.connectToDatabase();
      await conn.query(
          "update deposit set $key = ? where id = ${deposit.id}", [value]);

      conn.close();
      sucess = true;
    }

    return sucess;
  }

  //Deletar Produto:
  Future<String> depositDelete(String id) async {
    try {
      MySqlConnection conn = await db.connectToDatabase();
      Results result =
          await conn.query('delete from deposit where id = ?', [id]);
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