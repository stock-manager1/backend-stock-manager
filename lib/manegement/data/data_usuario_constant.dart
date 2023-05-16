const String userTableName = 'usuario';
const String userColumnid = 'usuarioId';
const String userColumnLogin = 'login';
const String userColumnSenha = 'senha';

const String createUserTable = '''
  CREATE TABLE $userTableName (
    $userColumnid INTEGER PRIMARY KEY AUTO_INCREMENT,
    $userColumnLogin TEXT NOT NULL,
    $userColumnSenha TEXT NOT NULL
  )
''';