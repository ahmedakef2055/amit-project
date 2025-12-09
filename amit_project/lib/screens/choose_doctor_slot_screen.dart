import 'package:flutter/material.dart';

class ChooseDoctorSlotScreen extends StatefulWidget {
  final DateTime date;
  final String time;

  const ChooseDoctorSlotScreen({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  State<ChooseDoctorSlotScreen> createState() => _ChooseDoctorSlotScreenState();
}

class _ChooseDoctorSlotScreenState extends State<ChooseDoctorSlotScreen> {
  String selectedVisit = "In-Person";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Choose Slot",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
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

            // Doctor Info (Mocked - بدلها ببيانات الدكتور بتاعك لو حابب)
            Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/gh.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Dr. Randy Wigham",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text("General | RSUD Gatot Subroto",
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text("Visit Type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),

            Row(
              children: [
                _visitTypeCard("In-Person", Icons.home),
                const SizedBox(width: 12),
                _visitTypeCard("Video Call", Icons.videocam),
              ],
            ),

            const SizedBox(height: 25),

            const Text("Appointment Slot",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.watch_later_outlined, size: 30, color: Colors.black54),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${widget.time}   •   ${widget.date.day}/${widget.date.month}/${widget.date.year}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(
                        date: widget.date,
                        time: widget.time,
                        visitType: selectedVisit,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3FA2F7),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Visit Type Widget
  Widget _visitTypeCard(String label, IconData icon) {
    bool active = selectedVisit == label;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedVisit = label);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: active ? const Color(0xff3FA2F7) : Colors.grey.shade200,
          ),
          child: Column(
            children: [
              Icon(icon, color: active ? Colors.white : Colors.black87),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: active ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------
// PAYMENT SCREEN PLACEHOLDER
// --------------------------------------

class PaymentScreen extends StatelessWidget {
  final DateTime date;
  final String time;
  final String visitType;

  const PaymentScreen({
    super.key,
    required this.date,
    required this.time,
    required this.visitType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(
        child: Text("Payment Page Coming Next…"),
      ),
    );
  }
}
