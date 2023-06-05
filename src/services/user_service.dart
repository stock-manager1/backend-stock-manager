import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../util/jwt_auth.dart';
import '../util/password_bcrypt.dart';

class UserService {
  UserRepository userRepository = UserRepository();

  //Registrar Usuário:
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

  //Login Usuário:
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

  //Encontrar Usuário:
  Future<User> find(String key, String value) async {
    User user = await userRepository.find(key, value);
    return user;
  }

  //Listar Usuario:
  Future<List<User>> listAllUser() async {
    List<User> allUsers = await userRepository.listAllUser();

    return allUsers;
  }

  //Alterar Usuário:
  Future<bool> updateUser(
      String id, String email, String key, String value) async {
    bool sucess = false;

    if (key == "name" || key == "brand" || key == "type") {
      sucess = await userRepository.userUpdate(id, email, key, value);
    }

    return sucess;
  }

  //Deletar Usuário:
  Future<String> delete(String id) async {
    try {
      return await userRepository.delete(id);
    } catch (e) {
      return e.toString();
    }
  }
}
