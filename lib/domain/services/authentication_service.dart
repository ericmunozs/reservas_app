import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<void> login(String emailAddress, String password);
  Future<UserCredential> signup(String emailAddress, String password);
  Future<void> logout();
}
