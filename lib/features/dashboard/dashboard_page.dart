import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final List<String> products = ["Users", "Categories", "Products", "hello"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        child: ListView(
          children: [
            ExpansionTile(
              title: Text("Users"),
              children: [
                ListTile(title: Text("happy")),
                ListTile(title: Text("sad")),
                ListTile(title: Text("angry")),
              ],
            ),
            ExpansionTile(
              title: Text("Categories"),
              children: [
                ListTile(title: Text("happy")),
                ListTile(title: Text("sad")),
                ListTile(title: Text("angry")),
              ],
            ),
            ExpansionTile(
              title: Text("Products"),
              children: [
                ListTile(title: Text("happy")),
                ListTile(title: Text("sad")),
                ListTile(title: Text("angry")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
