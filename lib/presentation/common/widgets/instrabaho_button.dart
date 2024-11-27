import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class InstrabahoButton extends StatelessWidget {
  const InstrabahoButton(
      {super.key,
      required this.label,
      this.isTwoTone = false,
      this.onTap,
      this.verticalMargin = 0.0,
      this.horizontalMargin = 0.0,
      this.outline = false,
      this.borderColor,
      this.bgColor});

  final String label;
  final bool isTwoTone;
  final Function()? onTap;
  final double verticalMargin;
  final double horizontalMargin;
  final bool outline;
  final Color? borderColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: verticalMargin, horizontal: horizontalMargin),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
        decoration: BoxDecoration(
          color: outline
              ? Colors.transparent
              : (bgColor ?? (isTwoTone ? buttonColor : buttonColor)),
          gradient: isTwoTone && !outline
              ? LinearGradient(colors: [
                  buttonColor,
                  buttonColor.withOpacity(0.5),
                ])
              : null,
          border: outline
              ? Border.all(
                  color: borderColor ?? buttonColor,
                  strokeAlign: BorderSide.strokeAlignInside)
              : null,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Text(
            label,
            style: FontStyles.subheader.copyWith(
              color: outline ? (borderColor ?? buttonColor) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
