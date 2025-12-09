import 'package:flutter/material.dart';
import 'package:amit_project/models/doctor.dart';
import 'doctor_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  List<String> recentSearch = [
    "Dental",
    "General",
    "Nearest Hospital",
    "Neurologic"
  ];

  String selectedSpeciality = "All";

  List<Doctor> results = [];

  void onSearch(String text) {
    setState(() {
      results = results
          .where((d) =>
              d.name.toLowerCase().contains(text.toLowerCase()) ||
              d.specialization.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  void openFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) => _buildFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Search",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.shade100,
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: onSearch,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                GestureDetector(
                  onTap: openFilterSheet,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.filter_list),
                  ),
                )
              ],
            ),

            const SizedBox(height: 18),

            if (results.isEmpty) ...[
              const Text("Recent Search",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              for (var item in recentSearch)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item),
                    const Icon(Icons.close, size: 18),
                  ],
                ),

            ] else ...[
              Text("${results.length} found",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final doc = results[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DoctorDetailScreen(doctor: doc)),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
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
                                  image: doc.photo.startsWith('http')
                                      ? NetworkImage(doc.photo)
                                      : const AssetImage(
                                          'assets/images/Frame.png')
                                      as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doc.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(doc.specialization,
                                      style: const TextStyle(
                                          color: Colors.black54)),
                                  Text(doc.degree,
                                      style: const TextStyle(
                                          color: Colors.black45)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSheet() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Filter",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),

          const Text("Speciality",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            children: [
              specialityChip("All"),
              specialityChip("General"),
              specialityChip("Neurologic"),
              specialityChip("Pediatric"),
              specialityChip("Dermatologist"),
            ],
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onSearch(searchController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3FA2F7),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Apply Filter",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget specialityChip(String label) {
    final bool isSelected = selectedSpeciality == label;

    return GestureDetector(
      onTap: () {
        setState(() => selectedSpeciality = label);
      },
      child: Chip(
        label: Text(label),
        backgroundColor:
            isSelected ? const Color(0xff3FA2F7) : Colors.grey.shade200,
        labelStyle:
            TextStyle(color: isSelected ? Colors.white : Colors.black),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }
}
