import 'package:flutter/material.dart';
import 'package:reservas_app/data/authentication/firebase_authentication_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservas_app/presentation/widgets/language_selector.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuthenticationRepository _authService =
      FirebaseAuthenticationRepository();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LanguageSelector(),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _authService.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                } catch (e) {}
              },
              child: Text(AppLocalizations.of(context)!.logout),
            ),
          ],
        ),
      ),
    );
  }
}
