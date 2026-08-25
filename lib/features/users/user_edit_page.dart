import 'package:flutter/material.dart';
import 'package:hello/core/component/my_textfield.dart';
import 'package:hello/core/validators/user_validator.dart';
import 'package:hello/data/models/user_model.dart';
import 'package:hello/data/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../data/providers/language_provider.dart';

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
    _passwordController = TextEditingController();
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
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(languageProvider.translate('userEdit'))),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 24,
            children: [
              //username
              MyTextfield(
                controller: _usernameController,
                hintText: languageProvider.translate('username'),
                validator: UserValidator().validateUsername,
                obscureText: false,
              ),

              //usertitle
              MyTextfield(
                controller: _userTitleController,
                hintText: languageProvider.translate('userTitle'),
                validator: UserValidator().validateUserTitle,
                obscureText: false,
              ),

              //password
              MyTextfield(
                controller: _passwordController,
                hintText: languageProvider.translate('password'),
                validator: UserValidator().validatePasswordEdit,
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
                  final userProvider = context.read<UserProvider>();
                  final username = _usernameController.text.trim();
                  final userId = widget.user.id;
                  final password = _passwordController.text.trim();

                  if (!userProvider.isUsernameUnique(username, userId)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(languageProvider.translate('userExists')),
                      ),
                    );
                    return;
                  }

                  final updatedUser = UserModel(
                    id: widget.user.id,
                    username: username,
                    userTitle: _userTitleController.text,
                    password: password.isEmpty
                        ? widget.user.password
                        : password,
                  );
                  context.read<UserProvider>().updateUser(updatedUser);

                  Navigator.pop(context);
                },
                child: Text(languageProvider.translate('save')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
