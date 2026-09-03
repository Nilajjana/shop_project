import 'package:flutter/material.dart';
import 'package:businesssuiteapp/widgets/customer_name_field.dart';

/// =======================================
/// BILLING ITEMS PAGE
/// =======================================

class BillingItemsPage extends StatefulWidget {
  const BillingItemsPage({super.key});

  @override
  State<BillingItemsPage> createState() => _BillingItemsPageState();
}

class _BillingItemsPageState extends State<BillingItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Billing Items"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Customer Name
            const CustomerNameField(),

            const SizedBox(height: 20),

            /// More widgets will go here
            const Text(
              "Billing Items Page",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

