import 'package:flutter/material.dart'; //widgetları çağırır
import 'package:hello/data/providers/user_provider.dart'; //değişiklikleri ekranlara bildirir ve ekranlara ulaştırmayı sağlar.
import 'package:hello/data/repositories/user_repository.dart'; //kullanıcıları bulur ve işlemler yapar
import 'package:provider/provider.dart';
import 'features/auth/login_page.dart';

void main() {
  //main() fonksiyonu uygulama çalıştığında dartın ilk çalıştırdığı fonksiyon.
  runApp(
    //Flutterın çalıştıracağı widget treelerden oluşan uygulama burada belirtilir.
    ChangeNotifierProvider(
      //UserProvider'ı uygulamanın en dış, en üst kısmına koyuyoruz. Böyle uygulamanın içindeki bütün ekranlar değişiklik olduğunda bildirilebilir.
      create: (_) => UserProvider(
        UserRepository(),
      ), // repositorye sahip olan bir provider oluşturulur.
      // "_" fonksiyonda parantez içerisinde verilen bilgiyi kullanmadığımız için bu sembol kullanılır.
      // "=>" {return .....} kullanımının kısaltılmasıdır.
      child: const MyApp(), //Provider, myapp ve altındaki ekranları kapsar.
    ),
  );
}

class MyApp extends StatelessWidget {
  //MyApp ana ekran yapısıdır. Kendi içinde değişen bir veri tutmadığı için stateless kullanılır.
  const MyApp({super.key}); // MyApp(), MyApp uygulamasının kurucusu.
  //super.key ise gelen key değerini bir üst sınıfa yani Stateless Widgeta gönderir. Key ise Flutterın widgetları ayırt edilebilmesi için gerekli olan özelliktir
  //const ise sabit zamanlı bir nesne oluşturmaya yarar.

  @override
  Widget build(BuildContext context) {
    //Widget, build fonksiyonun ne tür bir şey döndürceğini söyler. build ise Widgetın ekranda nasıl dönüceğini söyler.
    //'BuildContext context' build fonksiyonuna verilen bilgidir: Bu widget şuanda nerede bilgisini taşır.  Widget ağacı arasındaki ilişkiyi bilir.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ); //MyAppin nasıl görüleceğini belirler.
  }
}
