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
      this.width,
      this.icon,
      this.hugContent = false,
      this.textColor,
      this.fontSize,
      this.borderRadius = 60.0,
      this.splashColor,
      this.padding});

  final String label;
  final bool isTwoTone;
  final Function()? onTap;
  final double verticalMargin;
  final double horizontalMargin;
  final bool outline;
  final Color? borderColor;
  final Color? bgColor;
  final double? height;
  final double? width;
  final Widget? icon;
  final bool hugContent;
  final Color? textColor;
  final double? fontSize;
  final double borderRadius;
  final Color? splashColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      splashFactory: InkRipple.splashFactory,
      splashColor: splashColor ?? Colors.transparent,
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1.0,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: verticalMargin, horizontal: horizontalMargin),
          height: height,
          width: width,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: outline
                ? Colors.transparent
                : (bgColor ?? (isTwoTone ? C.blue700 : C.blue700)),
            gradient: isTwoTone && !outline
                ? LinearGradient(colors: [
                    C.blue600,
                    C.blue600.withOpacity(0.5),
                  ])
                : null,
            border: outline
                ? Border.all(
                    color: borderColor ?? C.blue600,
                    strokeAlign: BorderSide.strokeAlignInside)
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisSize: hugContent ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center, // Ensures centering
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Flexible(
                  child: hugContent
                      ? Text(
                          textAlign: TextAlign.center,
                          label,
                          overflow: TextOverflow.ellipsis,
                          style: FontStyles.subheader.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: fontSize ?? 16,
                            color: textColor ??
                                (outline
                                    ? (borderColor ?? C.blue600)
                                    : Colors.white),
                          ),
                        )
                      : Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: FontStyles.subheader.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize ?? 16,
                              color: textColor ??
                                  (outline
                                      ? (borderColor ?? C.blue600)
                                      : Colors.white),
                            ),
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
