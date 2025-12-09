import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amit_project/models/doctor.dart';
import 'package:amit_project/features/doctors/doctor_service.dart';
import '../features/auth/auth_service.dart';
import 'doctor_detail_screen.dart';

class RecommendationDoctorScreen extends StatefulWidget {
  const RecommendationDoctorScreen({super.key});

  @override
  State<RecommendationDoctorScreen> createState() =>
      _RecommendationDoctorScreenState();
}

class _RecommendationDoctorScreenState
    extends State<RecommendationDoctorScreen> {
  Future<List<Doctor>>? futureDoctors; // <<< ✔️ بقت nullable

  @override
  void initState() {
    super.initState();
    loadDoctors();
  }

  void loadDoctors() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    final token = await auth.getToken();

    print("📌 TOKEN IN RECOMMENDATION: $token");

    setState(() {
      futureDoctors = DoctorService.getAllDoctors(token ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Recommendation Doctor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.more_horiz, size: 28),
          SizedBox(width: 12),
        ],
      ),

      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: futureDoctors == null
                ? const Center(child: CircularProgressIndicator()) // لسه بيجيب بيانات
                : FutureBuilder<List<Doctor>>(
                    future: futureDoctors,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No doctors found"));
                      }

                      final doctors = snapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _doctorItem(context, doctor),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _doctorItem(BuildContext context, Doctor doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailScreen(doctor: doctor),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.
          all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(doctor.photo),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialization,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.city,
                    style: const TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
