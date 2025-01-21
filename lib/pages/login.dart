// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_manager/db/book_db.dart';
import 'package:library_manager/pages/home.dart';
import 'package:library_manager/utils/add_sample.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final storedPassword = prefs.getString('password');

    if (_usernameController.text == storedUsername &&
        _passwordController.text == storedPassword) {
      await BookDB.instance.clearDatabase();
      await addSampleBooks();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro no login'),
          content: const Text('Usuário ou senha inválido'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _register() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('password', _passwordController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrado com sucesso'),
        content: const Text(
            'Agora você pode fazer o login com as suas credenciais.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _resetPassword() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username')) {
      await prefs.remove('password');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Resetar Senha'),
          content: const Text(
              'Sua senha foi resetada, por favor crie um usuário com a nova senha.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content:
              const Text('Não encontramos um usuário para resetar a senha.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: SvgPicture.network(
                "https://portal.imd.ufrn.br/portal/assets/images/nova-marca/1A-Primaria-Gradiente.svg",
                height: 48,
              ),
            ),
            const Spacer(),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                onPressed: _register,
                child: const Text('Registrar novo usuário'),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                onPressed: _resetPassword,
                child: const Text('Resetar senha'),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
