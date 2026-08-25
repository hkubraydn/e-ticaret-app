import 'package:flutter/material.dart';
import 'package:hello/features/categories/category_list_page.dart';
import 'package:hello/features/products/product_list_page.dart';
import 'package:hello/features/users/user_list_page.dart';
import 'package:provider/provider.dart';
//import '../../features/users/user_add_page.dart';
import '../../data/providers/language_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 24,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, //şuan nerede olduğumuzu belirtiyomuş
                    MaterialPageRoute(
                      builder: (context) => UserListPage(),
                      //builder: hangi widgeti oluşturcaz verisiymiş örneğin burda DashBoard page widgeti oluşturuyoruz.
                    ),
                  );
                },
                child: Text("Users"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, //şuan nerede olduğumuzu belirtiyomuş
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(),
                      //builder: hangi widgeti oluşturcaz verisiymiş örneğin burda DashBoard page widgeti oluşturuyoruz.
                    ),
                  );
                },
                child: Text("Categories"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, //şuan nerede olduğumuzu belirtiyomuş
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(),
                      //builder: hangi widgeti oluşturcaz verisiymiş örneğin burda DashBoard page widgeti oluşturuyoruz.
                    ),
                  );
                },
                child: Text("Products"),
              ),
              IconButton(
                icon: const Icon(Icons.language),
                onPressed: () {
                  // Aktif provider'ı dinlemeden (listen: false veya read) alıyoruz
                  final languageProvider = context.read<LanguageProvider>();

                  // Eğer dil Türkçe ise İngilizce yap, İngilizce ise Türkçe yap
                  if (languageProvider.currentLocale.languageCode == 'tr') {
                    languageProvider.changeLanguage('en');
                  } else {
                    languageProvider.changeLanguage('tr');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
