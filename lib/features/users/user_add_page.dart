import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/component/my_textfield.dart';
import '../../core/validators/user_validator.dart';
import '../../data/models/user_model.dart';
import '../../data/providers/user_provider.dart';

class UserAddPage extends StatefulWidget {
  const UserAddPage({super.key});

  @override
  State<UserAddPage> createState() => _UserAddPage();
}

class _UserAddPage extends State<UserAddPage> {
  final _usernameController = TextEditingController();
  final _userTitleController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _userTitleController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
                //username
                MyTextfield(
                  controller: _usernameController,
                  hintText: "Username",
                  validator: UserValidator().validateUsername,
                  obscureText: false,
                ),

                //user title
                MyTextfield(
                  controller: _userTitleController,
                  hintText: "User Title",
                  validator: UserValidator().validateUserTitle,
                  obscureText: false,
                ),

                //password
                MyTextfield(
                  controller: _passwordController,
                  hintText: "Password",
                  validator: UserValidator().validatePassword,
                  obscureText: isPasswordHidden,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                ),

                //Add button
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    final username = _usernameController.text.trim();
                    final userProvider = context.read<UserProvider>();

                    if (!userProvider.isUsernameUnique(username, null)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bu kullanıcı adı zaten kayıtlı'),
                        ),
                      );
                      return;
                    }

                    final newUser = UserModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      username: _usernameController.text,
                      userTitle: _userTitleController.text,
                      password: _passwordController.text,
                    );
                    context.read<UserProvider>().addUser(newUser);

                    Navigator.pop(context);
                  },
                  child: const Text("Add User"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
