import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/auth_service.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> logout(BuildContext context) async {
    final auth = context.read<AuthService>();
    await auth.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Setting"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _item(Icons.notifications_none, "Notification"),
          _item(Icons.help_outline, "FAQ"),
          _item(Icons.lock_outline, "Security"),
          _item(Icons.language, "Language"),

          const SizedBox(height: 10),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
