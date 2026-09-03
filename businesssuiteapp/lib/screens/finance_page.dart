import 'package:flutter/material.dart';

/// =======================================
/// FINANCE PAGE
/// =======================================

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  /// FUTURE FINANCE VARIABLES
  double totalRevenue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Finance & Analytics")),

      body: Center(
        child: Text(
          "Total Revenue: ₹${totalRevenue.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
