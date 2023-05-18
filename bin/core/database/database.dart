import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Database {
  Future<MySqlConnection> connectToDatabase() async {
    DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
    String host = env['HOSTNAME'].toString();
    int port = int.parse(env['PORT'].toString());
    String user = env['USERNAME'].toString();
    String password = env['PASSWORD'].toString();
    String database = env['DATABASE_NAME'].toString();

    final settings = ConnectionSettings(
      host: host, // Host do servidor MySQL
      port: port, // Porta do servidor MySQL (geralmente 3306)
      user: user, // Nome de usuário do MySQL
      password: password, // Senha do MySQL
      db: database, // Nome do banco de dados
    );

    MySqlConnection connection = await MySqlConnection.connect(settings);
    return connection;
  }
}
