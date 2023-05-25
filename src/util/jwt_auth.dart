import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';

class JwtAuth {
  static String generateJwtToken(int id) {
    DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
    final jwt = JWT({'id': id});
    return jwt.sign(SecretKey(env["SECRET_KEY"].toString()));
  }

  void verifyJwtToken(String token) {
    try {
      DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
      JWT.verify(token, SecretKey(env["SECRET_KEY"].toString()));
    } on JWTExpiredError {
      print('jwt expired');
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
    }
  }
}
