import 'package:flutter/material.dart';
import 'package:hello/core/component/my_textfield.dart';
import 'package:hello/core/validators/user_validator.dart';
import 'package:hello/data/models/user_model.dart';
import 'package:hello/data/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserEditPage extends StatefulWidget {
  final UserModel user;

  const UserEditPage({super.key, required this.user});

  @override
  State<UserEditPage> createState() => _UserEditPage();
}

class _UserEditPage extends State<UserEditPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _userTitleController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController(text: widget.user.username);
    _userTitleController = TextEditingController(text: widget.user.userTitle);
    _passwordController = TextEditingController(text: widget.user.password);
  }

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
      appBar: AppBar(title: Text("Edit User")),
      body: SafeArea(
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

              //usertitle
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
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  final username = _usernameController.text.trim();
                  final userProvider = context.read<UserProvider>();
                  final userId = widget.user.id;

                  if (!userProvider.isUsernameUnique(username, userId)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bu kullanıcı adı zaten kayıtlı'),
                      ),
                    );
                    return;
                  }

                  final updatedUser = UserModel(
                    id: widget.user.id,
                    username: username,
                    userTitle: _userTitleController.text,
                    password: _passwordController.text,
                  );
                  context.read<UserProvider>().updateUser(updatedUser);

                  Navigator.pop(context);
                },
                child: Text("Edit User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
