class Club {
  final String name;
  final String description;
  final String? image;
  final String? address;
  final String? phone;
  final String? email;
  final String? website;

  Club(
      {required this.name,
      required this.description,
      this.image,
      this.address,
      this.phone,
      this.email,
      this.website});
}

// Datos mock
List<Club> clubs = [
  Club(
    name: 'Club A',
    description: 'Descripción del Club A',
    image: 'https://via.placeholder.com/150',
    address: 'Dirección del Club A',
    phone: '1234567890',
    email: 'clubA@example.com',
    website: 'https://example.com',
  ),
  Club(
    name: 'Club B',
    description: 'Descripción del Club B',
    image: 'https://via.placeholder.com/150',
    address: 'Dirección del Club B',
    phone: '1234567890',
    email: 'clubB@example.com',
    website: 'https://example.com',
  ),
  // Agregar más clubs de ejemplo según sea necesario
];
