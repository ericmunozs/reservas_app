import 'package:firebase_auth/firebase_auth.dart';
import 'package:reservas_app/domain/services/authentication_service.dart';

class FirebaseAuthenticationRepository implements AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> login(String emailAddress, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No se encontró un usuario con ese correo electrónico.');
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta para ese usuario.');
      }
      rethrow;
    }
  }

  @override
  Future<UserCredential> signup(String emailAddress, String password) async {
    try {
      final credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      return credentials;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
