import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservas_app/data/authentication/firebase_authentication_repository.dart';
import 'package:reservas_app/presentation/screens/login/login.dart';
import 'package:reservas_app/presentation/screens/profile/profile.dart';
import 'package:reservas_app/presentation/widgets/club_list.dart';
import 'package:reservas_app/presentation/widgets/settings_button.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuthenticationRepository _authService =
      FirebaseAuthenticationRepository();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas App'),
        actions: [
          SettingsButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<User?>(
                      future: _authService.getCurrentUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          if (snapshot.data == null) {
                            return const LoginScreen();
                          }
                          return ProfileScreen(uid: snapshot.data!.uid);
                        }
                      },
                    ),
                  ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            ClubList(),
          ],
        ),
      ),
    );
  }
}
