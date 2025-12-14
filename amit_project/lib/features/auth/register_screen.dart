import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amit_project/features/auth/auth_service.dart';
import 'package:amit_project/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  int? gender; 

  bool isLoading = false;

  Future<void> registerUser() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passController.text.trim();
    final passwordConfirmation = passConfirmController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty || gender == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text("Please fill in all fields and select gender")),
      );
      return;
    }

    if (password != passwordConfirmation) {
      messenger.showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final auth = Provider.of<AuthService?>(context, listen: false) ?? AuthService();
      final result = await auth.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        gender: gender!,
      );

      if (!mounted) return; 

      if (result["status"] == true) {
        messenger.showSnackBar(
          const SnackBar(content: Text("Registration successful!")),
        );
        navigator.pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        messenger.showSnackBar(
          SnackBar(content: Text(result["message"] ?? "Registration failed")),
        );
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    passConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passConfirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<int>(
                value: gender,
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Male')),
                  DropdownMenuItem(value: 1, child: Text('Female')),
                ],
                onChanged: (val) => setState(() => gender = val),
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : registerUser,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xff007BFF),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
