class UserModel {
  final int id;
  String username;
  String userTitle;
  String password;
  bool isDeleted;

  UserModel({
    required this.id,
    required this.username,
    required this.userTitle,
    required this.password,
    this.isDeleted = false,
  });
}
