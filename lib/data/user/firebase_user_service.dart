import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservas_app/domain/models/user.dart';
import 'package:reservas_app/domain/services/user_service.dart';

class FirebaseUserRepository implements UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'users';

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
  Future<User?> getUserDetails(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection(_collectionName).doc(uid).get();

      if (userDoc.exists) {
        return User.fromFirestore(userDoc.data()!);
      } else {
        print('El documento del usuario con UID $uid no existe.');
        return null;
      }
    } catch (e) {
      print('Error getting user details: $e');
      rethrow;
    }
  }
}
