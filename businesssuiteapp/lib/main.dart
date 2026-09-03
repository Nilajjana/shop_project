import 'package:flutter/material.dart';
import 'screens/billing_page.dart';
import 'screens/inventory_page.dart';
import 'screens/finance_page.dart';
import 'widgets/option_card.dart';

void main() {
  runApp(const MyApp());
}

/// ROOT APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Suite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomePage(),
    );
  }
}

/// HOME PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// NAVIGATION METHOD
  void navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Business Suite"), centerTitle: true),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              /// BILLING
              OptionCard(
                icon: Icons.receipt_long,
                title: "Billing & Item Scan",
                subtitle: "Scan products and generate customer bills",
                color: Colors.blue,
                onTap: () {
                  navigateToPage(const BillingPage());
                },
              ),

              /// INVENTORY
              OptionCard(
                icon: Icons.inventory_2,
                title: "Inventory Management",
                subtitle: "Add, update and manage stock items",
                color: Colors.green,
                onTap: () {
                  navigateToPage(const InventoryPage());
                },
              ),

              /// FINANCE
              OptionCard(
                icon: Icons.account_balance_wallet,
                title: "Finance & Analytics",
                subtitle: "Track income, expenses and reports",
                color: Colors.orange,
                onTap: () {
                  navigateToPage(const FinancePage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
