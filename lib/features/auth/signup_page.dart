import 'package:flutter/material.dart';
import 'package:hello/core/widgets/my_textfield.dart';
import 'package:hello/features/auth/login_page.dart';
import 'package:hello/features/dashboard/dashboard_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final secondPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 255, 233),
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

                //name
                MyTextfield(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                //surname
                MyTextfield(
                  controller: surnameController,
                  hintText: 'Surname',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                //username
                MyTextfield(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                //email
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                //password
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                //password again
                MyTextfield(
                  controller: secondPasswordController,
                  hintText: 'Password Again',
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                //signup button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  },
                  child: const Text('Sign Up'),
                ),

                const SizedBox(height: 25),

                //already have an account?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.black),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),

                      Expanded(
                        child: Divider(thickness: 1, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text("Login"),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
