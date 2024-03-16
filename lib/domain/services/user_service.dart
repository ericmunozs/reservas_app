import 'package:reservas_app/domain/models/user.dart';

abstract class UserService {
  Future<void> addUserDetails(
      String uid, firstName, String lastName, String phone);
  Future<User?> getUserDetails(String uid);
}
