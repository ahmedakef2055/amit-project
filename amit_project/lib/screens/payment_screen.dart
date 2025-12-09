import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
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
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "Wallet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Payment",
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
            // ---------------- APPOINTMENT SUMMARY ----------------
            const Text(
              "Appointment Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(16),
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
                      image: const DecorationImage(
                        image: AssetImage("assets/images/gh.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Dr. Randy Wigham",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 4),
                        const Text("General | RSUD Gatot Subroto",
                            style: TextStyle(color: Colors.black54)),
                        const SizedBox(height: 8),
                        Text(
                          "${widget.time} | ${widget.date.day}/${widget.date.month}/${widget.date.year}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.visitType,
                            style: const TextStyle(color: Colors.black45)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- PAYMENT METHOD ----------------
            const Text(
              "Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 15),

            _paymentOption("Wallet", Icons.account_balance_wallet_outlined),
            const SizedBox(height: 12),

            _paymentOption("Credit / Debit Card", Icons.credit_card),
            const SizedBox(height: 12),

            _paymentOption("Cash", Icons.money),

            const Spacer(),

            // ---------------- CONFIRM BUTTON ----------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaymentSuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3FA2F7),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Confirm & Pay",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------- WIDGET: Payment Option ----------------------------
  Widget _paymentOption(String label, IconData icon) {
    final bool active = selectedMethod == label;

    return GestureDetector(
      onTap: () {
        setState(() => selectedMethod = label);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: active ? const Color(0xffE8F4FF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active ? const Color(0xff3FA2F7) : Colors.black12,
            width: active ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: active ? const Color(0xff3FA2F7) : Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: active ? const Color(0xff3FA2F7) : Colors.black26,
                    width: 2),
                color: active ? const Color(0xff3FA2F7) : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------------------- PAYMENT SUCCESS (FINAL SCREEN) ----------------------------
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 120, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Payment Successful!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text("Your appointment is confirmed.",
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}
