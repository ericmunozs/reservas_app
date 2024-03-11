abstract class AuthenticationService {
  Future<void> login(String emailAddress, String password);
  Future<void> signup(String emailAddress, String password);
  Future<void> logout();
}
