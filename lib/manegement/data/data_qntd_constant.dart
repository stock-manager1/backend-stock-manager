const String qntdTableName = 'qntdProduto';
const String qntdColumnId = 'produto_Id';
const String qntdColumnDeposito = 'deposito';
const String qntdColumnInventario = 'inventario';

const String createQntdTable = '''
  CREATE TABLE $qntdTableName (
    $qntdColumnId INTEGER PRIMARY KEY FOREIGN KEY,
    $qntdColumnDeposito INTEGER,
    $qntdColumnInventario INTEGER,

    FOREIGN KEY ($qntdColumnId) REFERENCES produto(produtoId)
  )
''';