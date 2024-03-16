import 'package:flutter/material.dart';
import 'package:reservas_app/data/authentication/firebase_authentication_repository.dart';
import 'package:reservas_app/data/user/firebase_user_service.dart';
import 'package:reservas_app/domain/models/user.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuthenticationRepository _authService =
      FirebaseAuthenticationRepository();
  final FirebaseUserRepository _userService = FirebaseUserRepository();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final user = await _userService.getUserDetails(widget.uid);
      setState(() {
        _user = user;
        _isLoading = false; // Marcamos que la carga ha terminado
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        _isLoading = false; // Marcamos que la carga ha terminado
      });
    }
  }

  Future<void> _logout() async {
    try {
      await _authService.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildProfileContent(),
    );
  }

  Widget _buildProfileContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_user != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${_user!.name}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Correo electrónico: ${_user!.email}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Teléfono: ${_user!.phone}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            )
          else
            Text(
              'Perfil sin datos',
              style: const TextStyle(fontSize: 18),
            ),
        ],
      ),
    );
  }
}
