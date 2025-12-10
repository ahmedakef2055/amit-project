import 'package:flutter/material.dart';
import 'package:amit_project/models/doctor.dart';
import 'package:amit_project/features/doctors/doctor_service.dart';
import 'doctor_detail_screen.dart';

class RecommendationDoctorScreen extends StatefulWidget {
  const RecommendationDoctorScreen({super.key});

  @override
  State<RecommendationDoctorScreen> createState() =>
      _RecommendationDoctorScreenState();
}

class _RecommendationDoctorScreenState
    extends State<RecommendationDoctorScreen> {
  List<Doctor> allDoctors = [];
  List<Doctor> filteredDoctors = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDoctors();
  }

  void loadDoctors() async {
    final result = await DoctorService.getAllDoctors();

    setState(() {
      allDoctors = result;
      filteredDoctors = result;
      loading = false;
    });
  }

  void searchDoctors(String query) {
    query = query.toLowerCase();

    setState(() {
      filteredDoctors = allDoctors.where((doctor) {
        final name = doctor.name.toLowerCase();
        final specialization = doctor.specialization.toLowerCase();
        final city = doctor.city.toLowerCase();

        return name.contains(query) ||
            specialization.contains(query) ||
            city.contains(query);
      }).toList();
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

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                    child: TextField(
                      onChanged: searchDoctors,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Expanded(
                  child: filteredDoctors.isEmpty
                      ? const Center(child: Text("No doctors found"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredDoctors.length,
                          itemBuilder: (context, index) {
                            final doctor = filteredDoctors[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _doctorItem(context, doctor),
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
          border: Border.all(color: Colors.black12),
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
