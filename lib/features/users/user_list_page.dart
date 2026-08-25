import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/user_provider.dart';
import '../users/user_add_page.dart';
import '../users/user_edit_page.dart';
import '../../data/providers/language_provider.dart';

/*Bu ekran Providerdaki kullanıcıları ekranda liste olarak gösterir.*/

class UserListPage extends StatelessWidget {
  //Sayfa değişikliği kendi içinde değil de Providerdan aldığı için Stateless yaptık.
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    //bu sayfa nasıl görünecek kısmı
    return Scaffold(
      //sayfa iskeleti
      appBar: AppBar(
        title: Text(languageProvider.translate('users')),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserAddPage()),
              );
            },
            icon: const Icon(Icons.add),
            tooltip: languageProvider.translate('userAdd'),
          ),
        ],
      ),

      body: Consumer<UserProvider>(
        //UserProviderda users listesini dinler, liste değişirse Bu ekranı güncelliyor.
        builder: (context, provider, child) {
          if (provider.users.isEmpty) {
            return Center(
              child: Text(languageProvider.translate('userNotFound')),
            );
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserEditPage(user: user),
                            ),
                          );
                        },
                      ),

                      //Delete işlemi
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  languageProvider.translate(
                                    'deleteAlertTitle',
                                  ),
                                ),
                                content: Text(
                                  languageProvider.translate(
                                    'deleteUserAlertText',
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      languageProvider.translate('cancel'),
                                    ),
                                  ),

                                  const SizedBox(width: 24),

                                  ElevatedButton(
                                    onPressed: () {
                                      debugPrint("soft deleted");
                                      context.read<UserProvider>().deleteUser(
                                        user.id,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      languageProvider.translate('delete'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
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
