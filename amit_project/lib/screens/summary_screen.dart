import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/appointment/appointment_provider.dart';
import '../features/appointment/appointment_service.dart';
import '../features/auth/auth_service.dart';
import 'booking_success_screen.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  String _to24Hour(String time) {
    final parts = time.split(' ');
    final hm = parts[0].split(':');
    int hour = int.parse(hm[0]);
    final minute = hm[1];
    final period = parts[1];

    if (period == "PM" && hour != 12) hour += 12;
    if (period == "AM" && hour == 12) hour = 0;

    return "${hour.toString().padLeft(2, '0')}:$minute";
  }

  @override
  Widget build(BuildContext context) {
    final appointment = context.watch<AppointmentProvider>();
    final auth = context.read<AuthService>();

    final startTime =
        "${appointment.date} ${_to24Hour(appointment.time!)}";

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Summary",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _sectionCard(
              title: "Booking Information",
              children: [
                _infoRow("Date & Time", startTime),
                _infoRow(
                  "Appointment Type",
                  _typeLabel(appointment.appointmentType),
                ),
              ],
            ),

            const SizedBox(height: 14),

            _sectionCard(
              title: "Payment Information",
              children: [
                _infoRow(
                  "Payment Method",
                  appointment.paymentMethod.toUpperCase(),
                ),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  final token = await auth.getToken();
                  if (token == null) return;

                  final success =
                      await AppointmentService.storeAppointment(
                    token: token,
                    doctorId: appointment.doctorId!,
                    startTime: startTime,
                    notes: "Booked from app",
                  );

                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingSuccessScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Booking failed"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3FA2F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Book Now",
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


  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case "in_person":
        return "In Person";
      case "video":
        return "Video Call";
      case "phone":
        return "Phone Call";
      default:
        return type;
    }
  }
}
