import 'package:flutter/material.dart';

class MyBottomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const MyBottomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 8),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.outlineVariant),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(color: Theme.of(context).colorScheme.outlineVariant, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
