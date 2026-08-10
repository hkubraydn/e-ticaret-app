import 'package:flutter/material.dart';
import 'package:hello/features/dashboard/dashboard_page.dart';
import '../../core/widgets/my_textfield.dart';
// ignore: unused_import
import '../../core/widgets/my_button.dart';
import '../../data/seed/user_seed.dart';
import '../../core/validators/user_validator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 255, 233),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                children: [
                  //logo
                  Image.asset(
                    'assets/images/Limon.png',
                    width: 200,
                    height: 200,
                  ),

                  //welcome text
                  Text(
                    'Welcome back, it\'s good to see you again!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 95, 0),
                      fontSize: 16,
                    ),
                  ),

                  //username textfield
                  MyTextfield(
                    controller: usernameController,
                    validator: UserValidator().validateUsername,
                    hintText: 'Username',
                    obscureText: false,
                  ),

                  //password textfield
                  MyTextfield(
                    controller: passwordController,
                    validator: UserValidator().validatePassword,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  //forgot password text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            debugPrint('Forgot Password button pressed');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //login button
                  ElevatedButton(
                    onPressed: () {
                      debugPrint("BUTONA BASILDI");

                      final result = _formKey.currentState!.validate();

                      debugPrint("VALIDATION RESULT: $result");

                      if (!result) {
                        return;
                      }

                      debugPrint("VALIDATION GEÇTİ");
                      if (!_formKey.currentState!.validate()) {
                        return; // Stop if the form is not valid
                      }

                      final username = usernameController.text;
                      final password = passwordController.text;

                      bool found = false;

                      for (var user in seedUsers) {
                        if (user.username == username &&
                            user.password == password) {
                          found = true;
                          break;
                        }
                      }
                      if (found) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("kullanıcı adı veya şifre yanlış"),
                          ),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
