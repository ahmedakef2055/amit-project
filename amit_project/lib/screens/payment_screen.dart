import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/appointment/appointment_provider.dart';
import 'summary_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointment = context.watch<AppointmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Payment Option",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _paymentCard(
                      context: context,
                      value: "card",
                      groupValue: appointment.paymentMethod,
                      title: "Credit Card",
                      subtitle: "Master Card / Visa",
                      icon: Icons.credit_card,
                      onChanged: appointment.setPaymentMethod,
                    ),

                    const SizedBox(height: 14),

                    _paymentCard(
                      context: context,
                      value: "paypal",
                      groupValue: appointment.paymentMethod,
                      title: "Paypal",
                      subtitle: "Pay via PayPal account",
                      icon: Icons.account_balance_wallet,
                      onChanged: appointment.setPaymentMethod,
                    ),

                    const SizedBox(height: 14),

                    _paymentCard(
                      context: context,
                      value: "cash",
                      groupValue: appointment.paymentMethod,
                      title: "Cash",
                      subtitle: "Pay at clinic",
                      icon: Icons.money,
                      onChanged: appointment.setPaymentMethod,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3FA2F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: appointment.paymentMethod == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SummaryScreen(),
                            ),
                          );
                        },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentCard({
    required BuildContext context,
    required String value,
    required String? groupValue,
    required String title,
    required String subtitle,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    final selected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xff3FA2F7)
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Icon(icon, color: const Color(0xff3FA2F7)),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            Radio<String>(
              value: value,
              groupValue: groupValue,
              activeColor: const Color(0xff3FA2F7),
              onChanged: (v) => onChanged(v!),
            ),
          ],
        ),
      ),
    );
  }
}
