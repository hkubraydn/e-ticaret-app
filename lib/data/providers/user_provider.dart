import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository repository;

  List<UserModel> users = [];

  UserProvider(this.repository);

  void loadUsers() {
    users = repository.getUsers();
    notifyListeners();
  }

  UserModel? login(String username, String password) {
    return repository.login(username, password);
  }

  void addUser(UserModel user) {
    repository.addUser(user);
    loadUsers();
  }

  void updateUser(UserModel updatedUser) {
    repository.updateUser(updatedUser);
    loadUsers();
  }

  void deleteUser(int id) {
    repository.deleteUser(id);
    loadUsers();
  }
}
