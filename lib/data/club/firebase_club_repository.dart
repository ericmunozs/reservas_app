import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservas_app/domain/models/club.dart';

class FirebaseClubRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'clubs';

  Future<List<Club>> getAllClubs() async {
    try {
      final querySnapshot = await _firestore.collection(_collectionName).get();
      final List<Club> clubs = querySnapshot.docs.map((doc) {
        return Club(
          name: doc['name'],
          description: doc['description'],
          image: doc['image'],
          address: doc['address'],
          phone: doc['phone'],
          email: doc['email'],
          website: doc['website'],
        );
      }).toList();
      return clubs;
    } catch (e) {
      print('Error fetching clubs: $e');
      throw e;
    }
  }

  Future<Club?> getClubDetails(String clubId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> clubDoc =
          await _firestore.collection(_collectionName).doc(clubId).get();
      if (clubDoc.exists) {
        final clubData = clubDoc.data()!;
        return Club(
          name: clubData['name'],
          description: clubData['description'],
          image: clubData['image'],
          address: clubData['address'],
          phone: clubData['phone'],
          email: clubData['email'],
          website: clubData['website'],
        );
      } else {
        return null; // El club no existe
      }
    } catch (e) {
      print('Error fetching club details: $e');
      throw e;
    }
  }
}
