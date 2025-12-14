import 'package:flutter/material.dart';
import '../features/auth/auth_service.dart';
import 'recommendation_doctor_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: _buildBottomNav(context),

      floatingActionButton: FloatingActionButton(
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          );
        },
        child: const Icon(Icons.search, size: 30),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hi, Omar!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "How Are You Today?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: const Icon(Icons.notifications_none),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xff3FA2F7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Book and schedule\nwith nearest doctor",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Find Nearby",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: 136,
                        height: 197,
                        child: Image.asset(
                          "assets/images/nurse.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Doctor Speciality",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff3FA2F7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _specialityItem("assets/images/Man Doctor Europe 1.png", "General"),
                  _specialityItem("assets/images/Brain 1.png", "Neurologic"),
                  _specialityItem("assets/images/iamge.png", "Pediatric"),
                  _specialityItem("assets/images/Kidneys 1.png", "Radiology"),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recommendation Doctor",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      final auth = AuthService();
                      final token = await auth.getToken() ?? '';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RecommendationDoctorScreen(token: token),
                        ),
                      );
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff3FA2F7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              _doctorCard(
                name: "Dr. Randy Wigham",
                subtitle: "General | RSUD Gatot Subroto",
                rating: "4.8 (4,279 reviews)",
                image: "assets/images/gh.png",
              ),

              const SizedBox(height: 15),

              _doctorCard(
                name: "Dr. Mayer Milton",
                subtitle: "Cardiologist | Mayo Clinic",
                rating: "4.9 (3,102 reviews)",
                image: "assets/images/kj.png",
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _specialityItem(String img, String title) {
    return Column(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(img),
          ),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  static Widget _doctorCard({
    required String name,
    required String subtitle,
    required String rating,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(rating,
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.home_filled, size: 28),
            const Icon(Icons.chat_bubble_outline, size: 26),
            const SizedBox(width: 40),
            const Icon(Icons.calendar_month, size: 26),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundImage:
                    AssetImage("assets/images/Group 637.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
