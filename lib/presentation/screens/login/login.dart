import 'package:flutter/material.dart';
import 'package:reservas_app/data/authentication/firebase_authentication_repository.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthenticationRepository authService =
      FirebaseAuthenticationRepository();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Ingrese su correo electrónico',
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Ingrese su contraseña',
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authService.login(
                    _emailController.text,
                    _passwordController.text,
                  );
                } catch (e) {}
              },
              child: const Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Crear una cuenta'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot-password');
              },
              child: const Text('¿Olvidó su contraseña?'),
            ),
          ],
        ),
      ),
    );
  }
}
