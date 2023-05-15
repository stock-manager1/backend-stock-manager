import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  //construtor privado
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }


  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'gerenciar.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_usuario);
    await db.execute(_inventario);
    await db.execute(_deposito);
    await db.execute(_produto);
    await db.execute(_qntdProduto);
    await db.execute(_transferir);
  }

  String get _usuario => '''
    CREATE TABLE usuario (
      id INTEGER PRIMARY KEY AUTO_INCREMENT,
      login TEXT,
      senha TEXT
    )

  ''';

  String get _inventario => '''
    CREATE TABLE inventario (
      id INTEGER PRIMARY KEY AUTO_INCREMENT,
      qntd_inventario INTEGER,
      capacidade INTEGER NOT NULL
    );

  ''';

  String get _deposito => '''
    CREATE TABLE deposito (
      id INTEGER PRIMARY KEY AUTO_INCREMENT,
      qntd_Estoque INTEGER,
      capacidade INTEGER NOT NULL    
    );

  ''';

  String get _produto => '''
    CREATE TABLE produto (
      id INTEGER PRIMARY KEY AUTO_INCREMENT,
      nome TEXT NOT NULL,
      marca TEXT NOT NULL,
      tipo TEXT NOT NULL,
      codigo INTEGER NOT NULL UNIQUE
    );

  ''';

  String get _qntdProduto => '''
    CREATE TABLE qntd_Produto (
      id_produto INTEGER PRIMARY KEY FOREIGN KEY,
      qntd_estoque INTEGER,
      qntd_inventario INTEGER
    );

  ''';
  
  String get _transferir => '''
    CREATE TABLE transferencia (
      id_produto INTEGER FOREIGN KEY,
      id_usuario INTEGER FOREIGN KEY,
      tipo TEXT,
      data DATETIME,
      FOREIGN KEY (id_produto) REFERENCES produto(id),
      FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    );

  ''';
}