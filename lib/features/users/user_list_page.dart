import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/user_provider.dart';
import '../users/user_add_page.dart';

/*Bu ekran Providerdaki kullanıcıları ekranda liste olarak gösterir.*/

class UserListPage extends StatelessWidget {
  //Sayfa değişikliği kendi içinde değil de Providerdan aldığı için Stateless yaptık.
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //bu sayfa nasıl görünecek kısmı
    return Scaffold(
      //sayfa iskeleti
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserAddPage()),
              );
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add User',
          ),
        ],
      ),

      body: Consumer<UserProvider>(
        //UserProviderda users listesini dinler, liste değişirse Bu ekranı güncelliyor.
        builder: (context, provider, child) {
          if (provider.users.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.users.length,
            itemBuilder: (context, index) {
              final user = provider.users[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: Text(
                      user.username[0], //Kullanıcı adinin ilk harfini alıyor
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  title: Text(
                    '${index + 1}. ${user.username}',
                  ), //Kullanıcı adını gösteriyor, index + 1 ile kullanıcı sıralamasını gösteriyor.
                  subtitle: Text(
                    user.userTitle,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () {},
                      ),

                      //Delete işlemi
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          context.read<UserProvider>().deleteUser(user.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
