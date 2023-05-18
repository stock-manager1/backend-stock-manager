const String depositoTableName = 'deposito';
const String depositoColumnId = 'depositoId';
const String depositoColumnCapacidade = 'capacidade';
const String depositoColumnQntd = 'quantidade';

const String createDepositoTable = '''
  CREATE TABLE $depositoTableName (
    $depositoColumnId INTEGER PRIMARY KEY AUTO_INCREMENT,
    $depositoColumnCapacidade INTEGER,
    $depositoColumnQntd INTEGER
  )
''';
