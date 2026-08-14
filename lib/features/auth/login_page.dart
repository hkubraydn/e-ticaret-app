import 'package:flutter/material.dart';
import 'package:hello/features/dashboard/dashboard_page.dart';
import '../../core/component/my_textfield.dart';
import '../../core/validators/user_validator.dart';
import '../../data/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  //Controller olduğu için stateful yapmak daha mantıklı.
  const LoginPage({super.key}); //flutterin ekrandaki widgetları ayırt etmesine yarar

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
  /* _ işareti bu değişkenin sadece bu dosya içerisinde kullanılacağını belirtir.
  Bu anahtarla girilen inputun forma uygun olup olmadığını belirtir*/

  bool isPasswordHidden = true; //buraya bir state ekledik

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
        child: SingleChildScrollView( //kaydırılabilir
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
                

                  //login button
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      } //formu kontrol e

                      final username = usernameController.text;
                      final password = passwordController.text;

                      final userProvider = context.read<UserProvider>();
                      //context.read<UserProvider>() user provider'da istediği fonksiyonu kullanır. Daha sonra providerda herhangi başka bir değişiklik olursa uyarılmaz

                      final user = userProvider.login(username, password); 
                      //username ve password, providera gönderilir, providersa repoya gönderir. Repositoryde login işlemi yapılır 
                      /*UserModel? login(String username, String password) {
                          for (var user in seedUsers) {
                          if (user.username == username &&
                              user.password == password &&
                              !user.isDeleted) {
                            return user;
                          }
                        }*/

                      if (user != null) {
                        Navigator.push(
                          context, //şuan nerede olduğumuzu belirtiyomuş
                          MaterialPageRoute(
                            builder: (context) => DashboardPage(),
                            //builder: hangi widgeti oluşturcaz verisiymiş örneğin burda DashBoard page widgeti oluşturuyoruz.
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
