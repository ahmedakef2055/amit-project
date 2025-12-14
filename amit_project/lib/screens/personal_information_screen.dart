import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/auth_service.dart';
import '../features/auth/user_service.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String gender = "male";
  bool loading = true;
  bool saving = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final auth = context.read<AuthService>();
    final token = await auth.getToken();
    if (token == null) return;

    final user = await UserService.getProfile(token);

    if (user != null) {
      nameController.text = user["name"] ?? "";
      emailController.text = user["email"] ?? "";
      phoneController.text = user["phone"] ?? "";
      gender = user["gender"] ?? "male";
    }

    setState(() => loading = false);
  }

  Future<void> save() async {
    setState(() => saving = true);

    final auth = context.read<AuthService>();
    final token = await auth.getToken();

    final success = await UserService.updateProfile(
      token: token!,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      gender: gender == "male" ? 0 : 1,
      password: passwordController.text.trim().isEmpty
          ? null
          : passwordController.text.trim(),
    );

    setState(() => saving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "Profile updated successfully" : "Update failed",
        ),
      ),
    );

    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _field("Full Name", nameController),
            _field("Email", emailController),
            _field("Phone", phoneController),

            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: "New Password (optional)",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () =>
                      setState(() => showPassword = !showPassword),
                ),
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: gender,
              items: const [
                DropdownMenuItem(value: "male", child: Text("Male")),
                DropdownMenuItem(value: "female", child: Text("Female")),
              ],
              onChanged: (v) => setState(() => gender = v!),
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saving ? null : save,
                child: saving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
