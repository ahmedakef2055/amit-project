import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/appointment/appointment_provider.dart';
import 'payment_screen.dart';

class ChooseDateScreen extends StatefulWidget {
  const ChooseDateScreen({super.key});

  @override
  State<ChooseDateScreen> createState() => _ChooseDateScreenState();
}

class _ChooseDateScreenState extends State<ChooseDateScreen> {
  int selectedDateIndex = -1;
  int selectedTimeIndex = -1;
  int selectedTypeIndex = 0;

  final times = [
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
  ];

  final appointmentTypes = [
    {"key": "in_person", "label": "In Person", "icon": Icons.person},
    {"key": "video", "label": "Video Call", "icon": Icons.videocam},
    {"key": "phone", "label": "Phone Call", "icon": Icons.call},
  ];

  @override
  Widget build(BuildContext context) {
    final appointment = context.watch<AppointmentProvider>();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Book Appointment",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Select Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final isSelected = selectedDateIndex == index;

                final date = DateTime.now().add(Duration(days: index));
                final formattedDate =
                    "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

                final dayName = [
                  "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
                ][date.weekday % 7];

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedDateIndex = index);
                    appointment.setDate(formattedDate);
                  },
                  child: Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff3FA2F7)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Text(
                          dayName,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            const Text(
              "Available Time",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(times.length, (index) {
                final isSelected = selectedTimeIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedTimeIndex = index);
                    appointment.setTime(times[index]);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 64) / 2,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff3FA2F7)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      times[index],
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            const Text(
              "Appointment Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Column(
              children: List.generate(appointmentTypes.length, (index) {
                final isSelected = selectedTypeIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedTypeIndex = index);
                    appointment.setAppointmentType(
                      appointmentTypes[index]["key"] as String,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xff3FA2F7)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          appointmentTypes[index]["icon"] as IconData,
                          color: const Color(0xff3FA2F7),
                        ),
                        const SizedBox(width: 12),
                        Text(appointmentTypes[index]["label"] as String),
                        const Spacer(),
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: const Color(0xff3FA2F7),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: appointment.isReady
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3FA2F7),
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
