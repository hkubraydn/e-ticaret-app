import 'package:flutter/material.dart';
import 'package:hello/features/auth/signup_page.dart';
// ignore: unused_import
import 'features/auth/login_page.dart';
// ignore: unused_import
import 'features/dashboard/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignUpPage());
  }
}
