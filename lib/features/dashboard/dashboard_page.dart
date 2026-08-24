import 'package:flutter/material.dart';
import 'package:hello/features/categories/category_list_page.dart';
import 'package:hello/features/products/product_list_page.dart';
import 'package:hello/features/users/user_list_page.dart';
//import '../../features/users/user_add_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
            ],
          ),
        ),
      ),
    );
  }
}
