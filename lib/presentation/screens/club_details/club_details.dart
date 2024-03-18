import 'package:flutter/material.dart';
import 'package:reservas_app/domain/models/club.dart';
import 'package:reservas_app/presentation/widgets/booking_schedule.dart';

class ClubDetailsScreen extends StatefulWidget {
  final Club club;

  const ClubDetailsScreen({super.key, required this.club});

  @override
  _ClubDetailsScreenState createState() => _ClubDetailsScreenState();
}

class _ClubDetailsScreenState extends State<ClubDetailsScreen> {
  bool isLiked = false;
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            widget.club.image ?? '',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.club.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  widget.club.address ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedTabIndex = 0;
                              });
                            },
                            child: Text(
                              'Home',
                              style: TextStyle(
                                color: selectedTabIndex == 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedTabIndex = 1;
                              });
                            },
                            child: Text(
                              'Reservar',
                              style: TextStyle(
                                color: selectedTabIndex == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: selectedTabIndex == 0
                        ? buildHomeContent()
                        : buildReservationContent(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Información del club:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text('Nombre: ${widget.club.name}'),
          Text('Dirección: ${widget.club.address ?? ''}'),
          Text('Descripción: ${widget.club.description ?? ''}'),
          Text('Teléfono: ${widget.club.phone ?? ''}'),
          Text('Correo electrónico: ${widget.club.email ?? ''}'),
          Text('Sitio web: ${widget.club.website ?? ''}'),
        ],
      ),
    );
  }

  Widget buildReservationContent() {
    return BookingSchedule();
  }
}
