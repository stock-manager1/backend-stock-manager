const String produtoTableName = 'produto';
const String produtoColumnId = 'produtoId';
const String produtoColumnNome = 'nome';
const String produtoColumnMarca = 'marca';
const String produtoColumnTipo = 'tipo';
const String produtoColumnDescricao = 'descricao';
const String produtoColumnCodigo = 'codigo';

const String createProdutoTable = '''
  CREATE TABLE $produtoTableName (
    $produtoColumnId INTEGER PRIMARY KEY AUTO_INCREMENT,
    $produtoColumnNome TEXT NOT NULL,
    $produtoColumnMarca TEXT NOT NULL,
    $produtoColumnTipo TEXT NOT NULL,
    $produtoColumnDescricao TEXT NOT NULL,
    $produtoColumnCodigo TEXT NOT NULL
  )
''';