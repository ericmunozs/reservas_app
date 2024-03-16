import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reservas_app/core/l10n/l10n.dart';
import 'package:reservas_app/presentation/screens/forgot_password/forgot_password.dart';
import 'package:reservas_app/presentation/screens/home/home.dart';
import 'package:reservas_app/presentation/screens/login/login.dart';
import 'package:reservas_app/presentation/screens/signup/signup.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AuthenticationWrapper());
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _AuthenticationWrapperState? state =
        context.findAncestorStateOfType<_AuthenticationWrapperState>();
    state?.setLocale(newLocale);
  }

  static Locale? getLocale(BuildContext context) {
    _AuthenticationWrapperState? state =
        context.findAncestorStateOfType<_AuthenticationWrapperState>();
    return state?.getLocale();
  }
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  Locale? _locale;

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  Locale? getLocale() {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return MaterialApp(
          onGenerateTitle: (context) {
            return AppLocalizations.of(context)!.appTitle;
          },
          supportedLocales: L10n.all,
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {
            '/signup': (context) => const SignupScreen(),
            '/forgot-password': (context) => const ForgotPasswordScreen(),
            '/home': (context) => HomeScreen(),
          },
          home: _buildHome(snapshot),
        );
      },
    );
  }

  Widget _buildHome(AsyncSnapshot<User?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    final User? user = snapshot.data;
    if (user == null) {
      return const LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
