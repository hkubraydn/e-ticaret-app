import '../models/user_model.dart';
import '../seed/user_seed.dart';

class UserRepository {
  List<UserModel> getUsers() {
    return seedUsers;
  }

  bool isUnique(String username) {
    for (var user in seedUsers) {
      if (user.username == username && !user.isDeleted) {
        return false;
      }
    }
    return true;
  }

  UserModel? login(String username, String password) {
    for (var user in seedUsers) {
      if (user.username == username &&
          user.password == password &&
          !user.isDeleted) {
        return user;
      }
    }

    return null;
  }

  void addUser(UserModel user) {
    seedUsers.add(user);
  }

  void updateUser(UserModel updatedUser) {
    final index = seedUsers.indexWhere((user) => user.id == updatedUser.id);

    if (index != -1) {
      seedUsers[index] = updatedUser;
    }
  }

  void deleteUser(int id) {
    final index = seedUsers.indexWhere((user) => user.id == id);

    if (index != -1) {
      seedUsers[index].isDeleted = true;
    }
  }
}
