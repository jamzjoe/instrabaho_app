import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class InstrabahoButton extends StatelessWidget {
  const InstrabahoButton(
      {super.key, required this.label, this.isTwoTone = false, this.onTap});

  final String label;
  final bool isTwoTone;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: isTwoTone ? primaryColor : primaryColor,
          gradient: isTwoTone
              ? LinearGradient(colors: [
                  primaryColor,
                  primaryColor.withOpacity(0.5),
                ])
              : null,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Text(
            label,
            style: FontStyles.subheader.copyWith(
              color: isTwoTone ? Colors.white : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
