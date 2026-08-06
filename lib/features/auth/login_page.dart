import 'package:flutter/material.dart';
import '../../core/widgets/my_textfield.dart';
import '../../core/widgets/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {
    debugPrint('Signing in...');
  }

  void signUserUp() {
    debugPrint('Signing up...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 255, 233),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),

                //logo
                Image.asset(
                  'lib/assets/images/Limon.png',
                  width: 200,
                  height: 200,
                ),

                const SizedBox(height: 25),

                //welcome text
                Text(
                  'Welcome back, it\'s good to see you again!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 95, 0),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 15),

                //username textfield
                MyTextfield(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textfield
                MyTextfield(
                  controller: passwordController,
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
                MyButton(onTap: signUserIn, text: "Login"),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.black),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          ' Don\'t have an account? ',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),

                      Expanded(
                        child: Divider(thickness: 1, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                MyButton(onTap: signUserUp, text: "Sign Up"),
                //not a member? register now text
              ],
            ),
          ),
        ),
      ),
    );
  }
}
