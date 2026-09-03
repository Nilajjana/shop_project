import 'package:flutter/material.dart';

/// =======================================
/// INVENTORY PAGE
/// =======================================

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  /// FUTURE INVENTORY DATA
  final List<String> stockItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory Management")),

      body: stockItems.isEmpty
          ? const Center(
              child: Text(
                "No stock items added yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: stockItems.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(stockItems[index]));
              },
            ),
    );
  }
}
