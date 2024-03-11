import 'package:flutter/material.dart';
import 'package:reservas_app/data/firebase_authentication_service.dart';
import 'package:reservas_app/presentation/screens/profile/profile.dart';
import 'package:reservas_app/presentation/widgets/settings_button.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuthenticationService authService =
      FirebaseAuthenticationService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), actions: [
        SettingsButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ]),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home screen!'),
          ],
        ),
      ),
    );
  }
}
