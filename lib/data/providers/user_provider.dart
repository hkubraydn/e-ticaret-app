import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  //bu sınıf değişiklikleri bildirebilecek
  final UserRepository
  repository; //UserRepository olarak değişmeyen bir repository tanımlanır. Yani değişiklikleri bu repository üzerinden çekeceğiz. Provider ise ekranı bilgilendirmeye yarayacak.

  List<UserModel> users =
      []; //ekranın kullanacağı kullanıcı listesi, UserModel type da kullanıcıları barındırır.

  UserProvider(this.repository) {
    users = repository.getUsers();
  } //UserProvider oluşturulurken bir repositorysinin olması gerekir, repo ise kullanıcıları bulur üzerinde değişiklik yapar.
  /*UserProvider(UserRepository repository) {
  this.repository = repository;
}*/

  UserModel? login(String username, String password) {
    return repository.login(username, password);
  } //provider verileri alır ve repositorye gönderir, repositoryde işlemi yapar ve providera geri gönderir.
  /*provider.login("hatice", "1234"); aldık diyelim 
provider bu bilgileri repository.login(....)'e veriyo
repo bu kullanıcıyı arıyo varsa user döndürüyo yoksa null
listeyi değiştirmediği için de loadUsers() kullanmaya gerek yok.*/

  void addUser(UserModel user) {
    //elimizde eklenecek bir user var.
    repository.addUser(
      user,
    ); //bu userı repositorydeki addUser kullanarak listemize ekleriz.
    users = repository.getUsers();
    notifyListeners(); //sonrasında notifyListener yaparak ekranları listenin değiştiğine dair bilgilendirir.
  }

  void updateUser(UserModel updatedUser) {
    //elimizde güncellencek bir kullanıcı var
    repository.updateUser(
      updatedUser,
    ); //repodaki updateUser kullanark kullanıcıyı güncelleriz
    notifyListeners(); //ekranlara değişiklik bildirilir
  }

  void deleteUser(int id) {
    repository.deleteUser(id);
    notifyListeners();
  }
}
