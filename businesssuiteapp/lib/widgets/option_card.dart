import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: SizedBox(
        width: double.infinity,
        height: 90,

        child: Card(
          elevation: 3,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Row(
                children: [
                  /// ICON
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: color.withOpacity(0.15),

                    child: Icon(icon, color: color, size: 28),
                  ),

                  const SizedBox(width: 18),

                  /// TEXT
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          title,

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          subtitle,

                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
