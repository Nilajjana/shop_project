import 'package:flutter/material.dart';

class DataEntryCard extends StatelessWidget {
  final String appBarTitle;

  final TextEditingController firstController;
  final TextEditingController secondController;

  final String firstLabel;
  final String secondLabel;

  final IconData firstIcon;
  final IconData secondIcon;

  final VoidCallback onButtonPressed;

  final String buttonText;

  const DataEntryCard({
    super.key,

    required this.appBarTitle,

    required this.firstController,
    required this.secondController,

    required this.firstLabel,
    required this.secondLabel,

    required this.firstIcon,
    required this.secondIcon,

    required this.onButtonPressed,

    this.buttonText = "Done",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// FIRST TEXTFIELD
            TextField(
              controller: firstController,

              decoration: InputDecoration(
                labelText: firstLabel,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                prefixIcon: Icon(firstIcon),
              ),
            ),

            const SizedBox(height: 20),

            /// SECOND TEXTFIELD
            TextField(
              controller: secondController,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: secondLabel,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                prefixIcon: Icon(secondIcon),
              ),
            ),

            const SizedBox(height: 30),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: onButtonPressed,

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                child: Text(buttonText, style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
