const String transferirTableName = 'transferencia';
const String transferirColumnIdUsuario = 'usuario_Id';
const String transferirColumnIdProduto = 'produto_Id';
const String transferirColumnData = 'data';
const String transferirColumnTipo = 'tipo';

const String createTransferirTable = '''
  CREATE TABLE $transferirTableName (
    $transferirColumnIdUsuario INTEGER FOREIGN KEY,
    $transferirColumnIdProduto INTEGER FOREIGN KEY,
    $transferirColumnData DATETIME,
    $transferirColumnTipo TEXT NOT NULL,
    FOREIGN KEY ($transferirColumnIdProduto) REFERENCES produto(produtoId),
    FOREIGN KEY ($transferirColumnIdUsuario) REFERENCES usuario(usuarioId)
  )
''';