import 'package:flutter/material.dart';
import 'package:hello/features/dashboard/dashboard_page.dart';
import '../../core/component/my_textfield.dart';
import '../../core/validators/user_validator.dart';
import '../../data/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  //Controller olduğu için stateful yapmak daha mantıklı.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
} /*<LoginPage> statein hangi widgeta ait olduğunu belirtir.
createState() state oluşturan fonksiyon
_LoginPageState() oluşan state nesnesidir.
*/

class _LoginPageState extends State<LoginPage> {
  /*Başındaki _ private sınıf olduğunu belirtir
_LoginPageState: Login ekranına ait geçici değişiklikleri tutar.
*/

  //yeni bir controller oluşturuyoz
  final usernameController =
      TextEditingController(); //Kullancı adı alanındaki yazıyı okumayı sağlayan sınıf. Kullanıcı ahmet yazarsa usernameController.text ile bu yazı okunabilir.
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // GlobalKey flutter içinde belirli bir widgeta ulaşmak için özel bir key
  //<FormState> bu anahtarın ulaşacağı widgettır. Form widgetının durumuna ulaşıcakmış
  //_formKeydeki _ sayesinde sadece bu dosyada kullanılabilir

  bool isPasswordHidden = true;

  @override
  void dispose() {
    // Kullanıcı sayfadan çıktığında çağrılır
    usernameController.dispose();
    passwordController.dispose();
    super.dispose(); //Statei temizler
  }

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
                spacing: 48,
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
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final username = usernameController.text;
                      final password = passwordController.text;

                      final userProvider = context.read<UserProvider>();

                      final user = userProvider.login(username, password);

                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Kullanıcı adı veya şifre yanlış"),
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
