class User {
  String name;
  String email;
  String? phone;
  String? gender;
  String? birthdate;

  User({
    required this.name,
    required this.email,
    this.phone,
    this.gender,
    this.birthdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'birthdate': birthdate,
    };
  }

  User.fromFirestore(Map<String, dynamic> firestore)
      : name = firestore['name'] ?? '',
        email = firestore['email'] ?? '',
        phone = firestore['phone'],
        gender = firestore['gender'],
        birthdate = firestore['birthdate'];
}
