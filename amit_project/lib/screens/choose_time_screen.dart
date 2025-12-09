import 'package:flutter/material.dart';

class ChooseTimeScreen extends StatefulWidget {
  final DateTime selectedDate;

  const ChooseTimeScreen({super.key, required this.selectedDate});

  @override
  State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  String? selectedTime;

  final List<String> morningTimes = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
  ];

  final List<String> afternoonTimes = [
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Choose Time",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Selected Date",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),

            const SizedBox(height: 6),

            Text(
              "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 25),

            const Text("Morning", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: morningTimes.map((time) {
                return _timeChip(time);
              }).toList(),
            ),

            const SizedBox(height: 25),

            const Text("Afternoon", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: afternoonTimes.map((time) {
                return _timeChip(time);
              }).toList(),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedTime == null
                    ? null
                    : () {
                        // NEXT SCREEN
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChooseDoctorSlotScreen(
                              time: selectedTime!,
                              date: widget.selectedDate,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3FA2F7),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Continue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeChip(String time) {
    bool isSelected = selectedTime == time;

    return GestureDetector(
      onTap: () {
        setState(() => selectedTime = time);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xff3FA2F7) : Colors.grey.shade200,
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


// ----------------------------------------------
// NEXT SCREEN (placeholder)
// ----------------------------------------------

class ChooseDoctorSlotScreen extends StatelessWidget {
  final String time;
  final DateTime date;

  const ChooseDoctorSlotScreen({super.key, required this.time, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Doctor Slot"),
      ),
      body: Center(
        child: Text("Next Step... ($time)"),
      ),
    );
  }
}
