import 'package:bcrypt/bcrypt.dart';

class PasswordBcrypt {
  static String hashPassword(String password) {
    final salt = BCrypt.gensalt();
    final hashedPassword = BCrypt.hashpw(password, salt);
    return hashedPassword;
  }

  static bool checkPassword(String password, String hashedPassword) {
    final bool checkPassword = BCrypt.checkpw(password, hashedPassword);
    return checkPassword;
  }
}
