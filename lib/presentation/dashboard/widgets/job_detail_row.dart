import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class JobDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isAmount;
  final bool isStatus;

  const JobDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isAmount = false,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child = isAmount
        ? IntrinsicWidth(
            child: Container(
              decoration: BoxDecoration(
                color: C.blue700.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                value,
                style: context.textTheme.defaultBold.copyWith(
                  color: C.blue700,
                ),
              ),
            ),
          )
        : isStatus
            ? Text(
                value,
                style: context.textTheme.defaultBold.copyWith(
                  color: Colors.green,
                ),
              )
            : Text(
                value,
                style: context.textTheme.defaultBold,
              );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: context.textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: child,
          ),
        ),
      ],
    );
  }
}
