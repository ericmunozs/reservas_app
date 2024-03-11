import 'package:flutter/material.dart';
import 'package:reservas_app/domain/models/club.dart';
import 'package:reservas_app/presentation/screens/club_details/club_details.dart';
import 'package:reservas_app/presentation/screens/profile/profile.dart';
import 'package:reservas_app/presentation/widgets/settings_button.dart';

class ClubListScreen extends StatelessWidget {
  const ClubListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clubs'), actions: [
        SettingsButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ]),
      body: ListView.builder(
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];
          return ListTile(
            title: Text(club.name),
            subtitle: Text(club.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClubDetailsScreen(club: club),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
