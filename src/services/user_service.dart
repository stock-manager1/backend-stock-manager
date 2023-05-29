import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../util/jwt_auth.dart';
import '../util/password_bcrypt.dart';

class UserService {
  UserRepository userRepository = UserRepository();

  Future<User> find(String key, String value) async {
    User user = await userRepository.find(key, value);
    return user;
  }

  Future<String> delete(String id) async {
    try {
      return await userRepository.delete(id);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login(String email, String password) async {
    User user = await userRepository.find("email", email);
    if (user.isEmpty()) {
      throw Exception("Usuário não encontrado!");
    }

    bool passVerify = PasswordBcrypt.checkPassword(password, user.password);

    if (!passVerify) {
      throw Exception("Senha incorreta");
    }

    final token = JwtAuth.generateJwtToken(user.id);
    return token;
  }

  Future<void> register(String email, String password, String name) async {
    User user = await userRepository.find("email", email);
    if (!user.isEmpty()) {
      throw Exception("Usuário já cadastrado!");
    }

    User userRegister = User(
        email: email,
        name: name,
        password: PasswordBcrypt.hashPassword(password));

    userRepository.userRegister(userRegister);
  }
}
