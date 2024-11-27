import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String normalText;
  final String boldText;
  final String trailingText;

  const CustomRichText({
    super.key,
    required this.normalText,
    required this.boldText,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: const TextStyle(
          //line height 28px
          height: 1.4),
      TextSpan(
          text: normalText,
          children: [
            TextSpan(
                text: boldText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: trailingText,
            ),
          ],
          style: const TextStyle(fontSize: 18) // Default text style
          ),
    );
  }
}
