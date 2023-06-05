
import 'package:shelf/shelf.dart';

import '../models/deposit.dart';
import '../repositories/deposit_repository.dart';

class DepositService {
  final _depositRepository = DepositRepository();

  // Registrar Deposito:
  Future<bool> depositRegister(Request request) async {
    final depositRq = Deposit.fromJson(await request.readAsString());
    await _depositRepository.depositRegister(depositRq);

    return true;
  }

  // Listar Depositos:
  Future<List<Deposit>> listAllDeposits() async {
    List<Deposit> allDeposits = await _depositRepository.listAllDeposits();

    return allDeposits;
  }

  // Encontrar Deposito:
  Future<Deposit> depositFind(String key, String value) async {
    Deposit deposit = await _depositRepository.depositFind(key, value);
    return deposit;
  }

  // Alterar Deposito:
  Future<bool> updateDeposit(String id, String key, String value) async {
    bool sucess = false;

    if (key == "capacity" || key == "amount" || key == "address" || key == 'name') {
      sucess = await _depositRepository.depositUpdate(id, key, value);
    }

    return sucess;
  }

  // Deletar Deposito:
  Future<String> depositDelete(String id) async {
    try {
      return await _depositRepository.depositDelete(id);
    } catch (e) {
      return e.toString();
    }
  }
}