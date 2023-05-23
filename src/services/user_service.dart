import '../models/user.dart';
import '../repositories/user_repository.dart';

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
}
