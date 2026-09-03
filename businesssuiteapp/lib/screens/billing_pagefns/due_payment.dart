import 'package:flutter/material.dart';
import 'package:businesssuiteapp/widgets/data_entry_card.dart';

class DuePaymentPage extends StatefulWidget {
  const DuePaymentPage({super.key});

  @override
  State<DuePaymentPage> createState() => _DuePaymentPageState();
}

class _DuePaymentPageState extends State<DuePaymentPage> {
  /// CONTROLLERS
  final TextEditingController customerController = TextEditingController();

  final TextEditingController amountPaidController = TextEditingController();

  /// SAMPLE DUE DATABASE
  /// Later you can replace this with SQLite/Firebase
  final Map<String, double> customerDueAmounts = {
    "Rahul": 5000,
    "Amit": 3200,
    "Suresh": 1800,
  };

  /// RESULT VARIABLES
  double remainingAmount = 0;
  String customerName = "";

  /// PROCESS PAYMENT
  void processPayment() {
    final String enteredName = customerController.text.trim();

    final double paidAmount =
        double.tryParse(amountPaidController.text.trim()) ?? 0;

    /// CHECK CUSTOMER EXISTS
    if (!customerDueAmounts.containsKey(enteredName)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Customer not found")));
      return;
    }

    final double totalDue = customerDueAmounts[enteredName]!;

    final double remaining = totalDue - paidAmount;

    /// NAVIGATE TO RESULT PAGE
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentResultPage(
          customerName: enteredName,
          remainingAmount: remaining,
        ),
      ),
    );
  }

  @override
  void dispose() {
    customerController.dispose();
    amountPaidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataEntryCard(
      appBarTitle: "Due Payments",

      firstController: customerController,

      secondController: amountPaidController,

      firstLabel: "Customer Name",

      secondLabel: "Amount Paid",

      firstIcon: Icons.person,

      secondIcon: Icons.currency_rupee,

      onButtonPressed: processPayment,
    );
  }
}

/// =======================================
/// RESULT PAGE
/// =======================================

class PaymentResultPage extends StatelessWidget {
  final String customerName;
  final double remainingAmount;

  const PaymentResultPage({
    super.key,
    required this.customerName,
    required this.remainingAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Status")),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(
            elevation: 4,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(25),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 70),

                  const SizedBox(height: 20),

                  Text(
                    customerName,

                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Remaining Due Amount",

                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "₹${remainingAmount.toStringAsFixed(2)}",

                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
