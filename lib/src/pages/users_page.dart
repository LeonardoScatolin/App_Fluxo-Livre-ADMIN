import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:app_fluxolivrep/src/providers/user_register_provider.dart';
import 'package:app_fluxolivrep/src/utils/show_erro_snackbar.dart';
import 'package:app_fluxolivrep/src/utils/show_success_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text('Usuários'),
      ),
      body: Consumer<UserRegisterProvider>(
        builder: (context, userProvider, child) {
          final users = userProvider.users;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFAFAE24),
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/edituser',
                            arguments: user,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Excluir Usuário'),
                              content: const Text(
                                'Tem certeza que deseja excluir este usuário?'
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text('Não'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await userProvider.deleteUser(user.id!);
                                      if (ctx.mounted) {
                                        Navigator.of(ctx).pop();
                                        showSuccessSnackBar(
                                          context,
                                          'Usuário excluído com sucesso!',
                                        );
                                      }
                                    } catch (error) {
                                      if (ctx.mounted) {
                                        Navigator.of(ctx).pop();
                                        showErroSnackBar(
                                          context,
                                          error.toString(),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text('Sim'),
                                ),
                              ],
                            ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFAFAE24),
        onPressed: () {
          Navigator.of(context).pushNamed('/novousuario');
        },
        child: const Icon(Icons.add, color: Color(0xFF000000)),
      ),
    );
  }
}