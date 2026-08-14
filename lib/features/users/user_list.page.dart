import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/user_provider.dart';

/*Bu ekran Providerdaki kullanıcıları ekranda liste olarak gösterir.*/

class UserListPage extends StatelessWidget {
  //Sayfa değişikliği kendi içinde değil de Providerdan aldığı için Stateless yaptık.
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //bu sayfa nasıl görünecek kısmı
    return Scaffold(
      //sayfa iskeleti
      appBar: AppBar(title: const Text('Users')),

      body: Consumer<UserProvider>(
        //UserProviderda users listesini dinler, liste değişirse Bu ekranı güncelliyor.
        builder: (context, provider, child) {
          if (provider.users.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          return ListView.builder(
            itemCount: provider.users.length,
            itemBuilder: (context, index) {
              final user = provider.users[index];

              return ListTile(
                title: Text(user.username),
                subtitle: Text(user.userTitle),
              );
            },
          );
        },
      ),
    );
  }
}