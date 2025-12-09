import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../../models/doctor.dart';
import '../../widgets/doctor_card.dart';
import 'doctor_service.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  bool loading = true;
  List<Doctor> doctors = [];

  @override
  void initState() {
    super.initState();
    loadDoctors();
  }

  Future<void> loadDoctors() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    final token = await auth.getToken();

    print("📌 TOKEN FROM PROVIDER: $token");

    if (token == null) {
      print("❌ No token found");
      setState(() => loading = false);
      return;
    }

    final result = await DoctorService.getAllDoctors(token);

    setState(() {
      doctors = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: Colors.blue,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : doctors.isEmpty
              ? const Center(child: Text("No Doctors Found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(doctor: doctors[index]);
                  },
                ),
    );
  }
}