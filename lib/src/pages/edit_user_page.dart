import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:app_fluxolivrep/src/providers/user_register_provider.dart';
import 'package:app_fluxolivrep/src/utils/show_erro_snackbar.dart';
import 'package:app_fluxolivrep/src/utils/show_success_snackbar.dart';
import 'package:app_fluxolivrep/src/widget/input_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _isLoading = false;
  User? _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_user == null) {
      final user = ModalRoute.of(context)?.settings.arguments as User?;
      if (user != null) {
        _user = user;
        _nomeController.text = user.name;
        _emailController.text = user.email;
      }
    }
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final user = User(
          id: _user!.id,
          name: _nomeController.text,
          email: _emailController.text,
          password: _senhaController.text.isEmpty ? _user!.password : _senhaController.text,
        );

        await Provider.of<UserRegisterProvider>(
          context,
          listen: false,
        ).updateUser(user);

        if (mounted) {
          showSuccessSnackBar(context, 'Usuário atualizado com sucesso!');
          Navigator.of(context).pop();
        }
      } catch (error) {
        if (mounted) {
          showErroSnackBar(context, error.toString());
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text('Editar Usuário'),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputLoginWidget(
                  controller: _nomeController,
                  icon: Icons.person_outlined,
                  hint: 'Nome',
                  validator: Validatorless.required('Campo Obrigatório'),
                  textStyle: const TextStyle(color: Colors.black87),
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  iconColor: Colors.black87,
                ),
                const SizedBox(height: 16),
                InputLoginWidget(
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  hint: 'E-mail',
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo Obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  textStyle: const TextStyle(color: Colors.black87),
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  iconColor: Colors.black87,
                ),
                const SizedBox(height: 16),
                InputLoginWidget(
                  controller: _senhaController,
                  icon: Icons.lock_outlined,
                  hint: 'Nova Senha (opcional)',
                  obscure: true,
                  validator: _senhaController.text.isEmpty
                      ? null
                      : Validatorless.min(8, 'Mínimo de 8 caracteres'),
                  textStyle: const TextStyle(color: Colors.black87),
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  iconColor: Colors.black87,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAFAE24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _isLoading ? null : _salvar,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF000000),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}