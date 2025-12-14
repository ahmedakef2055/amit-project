import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amit_project/models/doctor.dart';
import 'choose_date_screen.dart';
import '../features/appointment/appointment_provider.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  String safeText(String? value) {
    return (value == null || value.isEmpty) ? "Not available" : value;
  }

  ImageProvider safeImage(String? url) {
    if (url != null && url.startsWith("http")) {
      return NetworkImage(url);
    }
    return const AssetImage("assets/images/Frame.png");
  }

  void goToChooseDate(BuildContext context) {
    context.read<AppointmentProvider>().setDoctor(doctor.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChooseDateScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            doctor.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: const [
            Icon(Icons.more_horiz, color: Colors.black),
            SizedBox(width: 10),
          ],
        ),

        body: Column(
          children: [
            const TabBar(
              labelColor: Color(0xff3FA2F7),
              unselectedLabelColor: Colors.black54,
              indicatorColor: Color(0xff3FA2F7),
              tabs: [
                Tab(text: "About"),
                Tab(text: "Location"),
                Tab(text: "Reviews"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: safeImage(doctor.photo),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    doctor.specialization,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    safeText(doctor.degree),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "About Me",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          safeText(doctor.description),
                          style: const TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Working Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${safeText(doctor.startTime)} - ${safeText(doctor.endTime)}",
                          style: const TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Phone",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          safeText(doctor.phone),
                          style: const TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "City",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          safeText(doctor.city),
                          style: const TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => goToChooseDate(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff3FA2F7),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Make An Appointment",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Clinic Address",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          safeText(doctor.address),
                          style: const TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Location Map",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/map_placeholder.png",
                            height: 240,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => goToChooseDate(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff3FA2F7),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Make An Appointment",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Center(
                    child: Text(
                      "No Reviews Yet",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
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
