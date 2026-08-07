import 'package:flutter/material.dart';

class SeedUser {
  final String username;
  final String name;
  final String surname;
  final String email;
  final String password;

  SeedUser({
    required this.username,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });
}

final List<SeedUser> seedUsers = [
  SeedUser(
    username: "admin1",
    name: "Admin",
    surname: "User",
    email: "admin@test.com",
    password: "123456",
  ),
  SeedUser(
    username: "admin2",
    name: "Hatice",
    surname: "Aydın",
    email: "hatice@gmail.com",
    password: "123456",
  ),
];
