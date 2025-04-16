import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.style,
      this.color,
      this.fontWeight,
      this.fontSize});
  final String text;
  final TextStyle style;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;

  factory CustomText.appBar(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.body,
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize);
  }

  factory CustomText.header(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.header,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.title(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.subTitle.copyWith(color: C.textColor),
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.subTitle(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.subTitle
            .copyWith(color: C.textColor, fontSize: 17),
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.body(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.body,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.bodyLarge(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.bodyLarge ?? const TextStyle(fontSize: 14),
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.defaultBold(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.defaultBold,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.moneyText(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.moneyText,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.notes(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.noteStyle.copyWith(fontSize: 12),
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.notesBold(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.noteStyle.copyWith(fontSize: 12),
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize);
  }

  factory CustomText.buttonText(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.noteStyle.copyWith(fontSize: 13),
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize);
  }

  factory CustomText.rank(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.rankStyle,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.count(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.countStyle,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.caption(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.caption,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.amountLarge(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.amountTextLarge,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.amountMedium(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.amountTextMedium,
        color: color,
        fontSize: fontSize);
  }

  factory CustomText.name(BuildContext context, String text,
      {Color? color, double? fontSize}) {
    return CustomText(
        text: text,
        style: context.textTheme.nameStyle,
        color: color,
        fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: style.copyWith(
            color: color ?? style.color,
            fontWeight: fontWeight,
            fontSize: fontSize ?? style.fontSize));
  }
}
