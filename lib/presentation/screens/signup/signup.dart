import 'package:flutter/material.dart';
import 'package:reservas_app/data/authentication/firebase_authentication_repository.dart';
import 'package:reservas_app/data/user/firebase_user_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthenticationRepository _authService =
      FirebaseAuthenticationRepository();
  final FirebaseUserRepository _userService = FirebaseUserRepository();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regístrate'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu nombre y apellidos',
                  labelText: 'Nombre y apellidos',
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu correo electrónico',
                  labelText: 'Correo electrónico',
                ),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu teléfono',
                  labelText: 'Teléfono',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu contraseña',
                  labelText: 'Contraseña',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final name = _nameController.text.trim();
                  final email = _emailController.text.trim();
                  final phone = _phoneController.text.trim();
                  final password = _passwordController.text.trim();

                  try {
                    final credentials =
                        await _authService.signup(email, password);
                    await _userService.addUserDetails(
                        credentials.user!.uid, name, email, phone);
                    Navigator.pushReplacementNamed(context, '/home');
                  } catch (e) {}
                },
                child: const Text('Crear una cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
