import 'package:flutter/material.dart';
import 'package:businesssuiteapp/widgets/option_card.dart';
import 'package:businesssuiteapp/screens/billing_pagefns/billing_items_page.dart';
import 'package:businesssuiteapp/screens/billing_pagefns/due_payment.dart';

/// =======================================
/// BILLING PAGE
/// =======================================

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  /// NAVIGATION METHOD
  void navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Billing & Item Scan")),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            /// BILLING ITEMS
            OptionCard(
              icon: Icons.receipt_long,
              title: "Billing Items",
              subtitle: "Create customer bills and invoices",
              color: Colors.blue,
              onTap: () {
                navigateToPage(const BillingItemsPage());
              },
            ),

            /// DUE PAYMENTS
            OptionCard(
              icon: Icons.pending_actions,
              title: "Due Payments",
              subtitle: "Track pending customer payments",
              color: Colors.orange,
              onTap: () {
                navigateToPage(const DuePaymentPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
