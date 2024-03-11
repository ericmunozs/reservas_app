import 'package:flutter/material.dart';
import 'package:reservas_app/data/firebase_authentication_service.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuthenticationService authService =
      FirebaseAuthenticationService();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String emailAddress = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => emailAddress = value,
              decoration: const InputDecoration(
                hintText: 'Ingrese su correo electrónico',
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              onChanged: (value) => password = value,
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
                  await authService.login(emailAddress, password);
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
