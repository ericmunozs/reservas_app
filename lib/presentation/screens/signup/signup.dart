import 'package:flutter/material.dart';
import 'package:reservas_app/data/firebase_authentication_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthenticationService authService =
      FirebaseAuthenticationService();
  String emailAddress = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  emailAddress = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Ingrese su correo electrónico',
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
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
                  await authService.signup(emailAddress, password);
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {}
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
