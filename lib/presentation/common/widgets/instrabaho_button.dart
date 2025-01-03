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
      this.bgColor,
      this.height,
      this.icon});

  final String label;
  final bool isTwoTone;
  final Function()? onTap;
  final double verticalMargin;
  final double horizontalMargin;
  final bool outline;
  final Color? borderColor;
  final Color? bgColor;
  final double? height;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1.0,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: verticalMargin, horizontal: horizontalMargin),
          width: double.infinity,
          height: height,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyles.subheader.copyWith(
                      color:
                          outline ? (borderColor ?? buttonColor) : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
