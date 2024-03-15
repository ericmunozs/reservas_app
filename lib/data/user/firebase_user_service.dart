import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservas_app/domain/models/user.dart';
import 'package:reservas_app/domain/services/user_service.dart';

class FirebaseUserService implements UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'users';

  @override
  Future<User?> getUser(String email) async {
    try {
      var snapshot =
          await _firestore.collection(_collectionName).doc(email).get();
      if (snapshot.exists) {
        return User.fromFirestore(snapshot.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      rethrow;
    }
  }

  @override
  Future addUserDetails(String uid, name, String email, String phone) async {
    try {
      await _firestore.collection(_collectionName).doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
      });
    } catch (e) {
      print('Error adding user details: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateUser(String email, User newUser) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(email)
          .update(newUser.toMap());
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String email) async {
    try {
      await _firestore.collection(_collectionName).doc(email).delete();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }
}
