import 'package:backend/database/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UsuarioRepo extends ChangeNotifier {
  
  late Database db;
  late String _login;
  late String _senha;

  get login => _login;
  get senha => _senha;

  UsuarioRepo() {
    _initRepository();
  }

  _initRepository() async {
    await _getLogin();
  }

  _getLogin() async {
    db = await DB.instance.database;
    List usuario = await db.query('usuario');
    _login = usuario.first['login'];
    notifyListeners();
  }

  _getSenha() async {
    
  }
}