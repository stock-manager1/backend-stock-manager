const String inventarioTableName = 'inventario';
const String inventarioColumnId = 'inventarioId';
const String inventarioColumnCapacidade = 'capacidade';
const String inventarioColumnQuantidade = 'quantidade';

const String createInventarioTable = '''
  CREATE TABLE $inventarioTableName (
    $inventarioColumnId INTEGER PRIMARY KEY AUTO_INCREMENT,
    $inventarioColumnCapacidade INTEGER,
    $inventarioColumnQuantidade INTEGER
  )
''';