import 'package:flutter/material.dart';
import 'package:reservas_app/data/club/firebase_club_repository.dart';
import 'package:reservas_app/domain/models/club.dart';
import 'package:reservas_app/presentation/screens/club_details/club_details.dart';

class ClubList extends StatelessWidget {
  final FirebaseClubRepository _clubRepository = FirebaseClubRepository();

  ClubList({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Club>>(
      future: _clubRepository.getAllClubs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Club> clubs = snapshot.data ?? [];
          return SizedBox(
            height: 200, // Altura máxima para el ListView horizontal
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final club = clubs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClubDetailsScreen(club: club),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 200, // Ancho de la tarjeta del club
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  club.image ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    club.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    club.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
