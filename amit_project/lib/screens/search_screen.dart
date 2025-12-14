import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/auth_service.dart';
import '../features/doctors/doctor_service.dart';
import '../models/doctor.dart';
import 'doctor_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> allDoctors = [];
  List<dynamic> filteredDoctors = [];
  List<dynamic> specializations = [];
  List<dynamic> cities = [];

  String searchQuery = '';
  String? selectedSpecId;
  String? selectedCityId;
  String? token;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final auth = context.read<AuthService>();
    token = await auth.getToken();

    if (token == null) return;

    allDoctors = await DoctorService.getAllDoctors(token!);
    specializations = await DoctorService.getSpecializations(token!);
    cities = await DoctorService.getCities(token!);

    filteredDoctors = List.from(allDoctors);
    setState(() => loading = false);
  }

  void applyFilters() {
    filteredDoctors = allDoctors.where((doc) {
      final name = doc["name"].toString().toLowerCase();

      final matchName =
          searchQuery.isEmpty || name.contains(searchQuery.toLowerCase());

      final matchSpec = selectedSpecId == null ||
          doc["specialization"]["id"].toString() == selectedSpecId;

      final matchCity = selectedCityId == null ||
          doc["city"]["id"].toString() == selectedCityId;

      return matchName && matchSpec && matchCity;
    }).toList();

    setState(() {});
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
        title: const Text("Search Doctors"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (v) {
                searchQuery = v;
                applyFilters();
              },
              decoration: const InputDecoration(
                hintText: "Search by name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedSpecId,
              hint: const Text("Select specialization"),
              items: specializations.map((s) {
                return DropdownMenuItem(
                  value: s["id"].toString(),
                  child: Text(s["name"]),
                );
              }).toList(),
              onChanged: (v) {
                selectedSpecId = v;
                applyFilters();
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedCityId,
              hint: const Text("Select city"),
              items: cities.map((c) {
                return DropdownMenuItem(
                  value: c["id"].toString(),
                  child: Text(c["name"]),
                );
              }).toList(),
              onChanged: (v) {
                selectedCityId = v;
                applyFilters();
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: filteredDoctors.isEmpty
                  ? const Center(child: Text("No doctors found"))
                  : ListView.builder(
                      itemCount: filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doc = filteredDoctors[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DoctorDetailScreen(
                                    doctor: Doctor.fromJson(doc),
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(doc["photo"]),
                            ),
                            title: Text(doc["name"]),
                            subtitle: Text(
                              "${doc["specialization"]["name"]} • ${doc["city"]["name"]}",
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
