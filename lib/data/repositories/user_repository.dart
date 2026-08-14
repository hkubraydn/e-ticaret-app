import '../models/user_model.dart';
import '../seed/user_seed.dart';

class UserRepository {
  List<UserModel> getUsers() {
    //içinde UserModel türünden veriler bulunan bir liste dönücek.
    return seedUsers
        .where((user) => !user.isDeleted)
        .toList(); // seedUserstaki silinmiş olmayan kullanıcıları seç ve yeni bir liste oluştur.
  }

  bool isUnique(String username) {
    //kullanıcı adının unique olmasını sağlar.
    for (var user in seedUsers) {
      //seedUserstaki userları tek tek dolaşıyo,
      if (user.username == username && !user.isDeleted) {
        /*eğer input alınan username seedUserstaki bir userın usernamei ile aynıysa ve bu kullanıcı soft delete yapılmamışsa false döndürür. */
        return false;
      }
    }
    return true;
  }

  UserModel? login(String username, String password) {
    /*login fonk. UserModel türünde bir değer döndürecek veya null'da döndürebilir. ? buna yarar.*/
    for (var user in seedUsers) {
      /*seedUserstaki kullanıcılardan inputları uyuşanları döndürür. */
      if (user.username == username &&
          user.password == password &&
          !user.isDeleted) {
        return user;
      }
    }

    return null;
  }

  void addUser(UserModel user) {
    //fonks. bir şey döndürmüyo, sadece işlem. İşlem de kullanılacak verinin detayı da parantezde. UserModel tipinde user kullancak.
    seedUsers.add(user); //seedUsers listesine user ekleyecek.
  }

  void updateUser(UserModel updatedUser) {
    final index = seedUsers.indexWhere(
      (user) => user.id == updatedUser.id,
    ); // seedUserstagezerken değerlere geçici olarak user ismini vermiş, listedki userların userid si ile updatedUserın idsi eşitse user indexi kaydediliyo.

    if (index != -1) {
      //kullanıcı bulundu mu diye kontrol
      seedUsers[index] =
          updatedUser; //burada seedUsers[index] eski kullanıcıyken, güncellenmiş hali ile değiştiriliyor
    }
  }

  void deleteUser(int id) {
    final index = seedUsers.indexWhere(
      (user) => user.id == id,
    ); //yine seedUserstaki değerleri geçici olarak user ismini verip döndürüyo. idleri karşışaltırıyo eğer verilen idye eşit olan idnin indexini final olarak tanımlıyo

    if (index != -1) {
      //eğer id bulunduysa
      seedUsers[index].isDeleted =
          true; //soft delete yapmak için o indexe sahip olan kullanıcın isDeletedini tru yapyoz
    }
  }
}
