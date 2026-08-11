import 'package:flutter/material.dart';
import 'package:hello/data/providers/user_provider.dart';
import 'package:hello/data/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'features/auth/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(UserRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
