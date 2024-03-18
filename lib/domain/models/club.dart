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
