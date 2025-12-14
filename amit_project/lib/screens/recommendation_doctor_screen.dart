import 'package:flutter/material.dart';
import '../../features/home/home_service.dart';

class RecommendationDoctorScreen extends StatefulWidget {
  final String token;
  const RecommendationDoctorScreen({super.key, required this.token});

  @override
  State<RecommendationDoctorScreen> createState() =>
      _RecommendationDoctorScreenState();
}

class _RecommendationDoctorScreenState
    extends State<RecommendationDoctorScreen> {

  List<dynamic> doctors = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadHomeDoctors();
  }

  Future<void> loadHomeDoctors() async {
    doctors = await HomeService.getHomeDoctors(widget.token);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Doctors"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : doctors.isEmpty
              ? const Center(
                  child: Text(
                    "No doctors found",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doc = doctors[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(doc["photo"]),
                        ),
                        title: Text(
                          doc["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${doc["specialization"]["name"]} • ${doc["city"]["name"]}",
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
