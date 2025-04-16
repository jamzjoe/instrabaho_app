import 'package:flutter/material.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';

class FontStyles {
  static const TextStyle header = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subheader = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle welcomeText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle questionText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle tiny = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle appBarFont = TextStyle(
      fontSize: 28, fontWeight: FontWeight.w600, color: C.textColorDefault);

  static const TextStyle amountTextLarge = TextStyle(
      fontSize: 34, fontWeight: FontWeight.w700, color: C.textColorDefault);

  static const TextStyle amountTextMedium = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: C.textColorDefault);

  static const TextStyle instruction =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: C.textColor);

  static const TextStyle noteStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: C.textColorSecondary);
  static const TextStyle noteStyle15 = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: C.textColorSecondary);
  static const TextStyle bodyStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: C.textColorSecondary);

  static const TextStyle countStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: C.textColorTertiary);

  static const TextStyle rankStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: C.textColorTertiary);

  static const TextStyle subTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: C.textColorSecondary);

  static const TextStyle hintStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: C.textColorSecondary);
  static const TextStyle nameStyle = TextStyle(
      fontSize: 24, fontWeight: FontWeight.w700, color: C.textColorSecondary);
  //default bold
  static const TextStyle defaultBold = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: C.textColorSecondary);

  static const TextStyle moneyText = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: C.textColorDefault);
}

extension CustomTextTheme on TextTheme {
  TextStyle get header => FontStyles.header;
  TextStyle get subheader => FontStyles.subheader;
  TextStyle get body => FontStyles.body;
  TextStyle get caption => FontStyles.caption;
  TextStyle get tiny => FontStyles.tiny;
  TextStyle get appBarFont => FontStyles.appBarFont;
  TextStyle get instruction => FontStyles.instruction;
  TextStyle get noteStyle => FontStyles.noteStyle;
  TextStyle get noteStyle15 => FontStyles.noteStyle15;
  TextStyle get hintStyle => FontStyles.hintStyle;
  TextStyle get countStyle => FontStyles.countStyle;
  TextStyle get rankStyle => FontStyles.rankStyle;
  TextStyle get subTitle => FontStyles.subTitle;
  TextStyle get bodyStyle => FontStyles.bodyStyle;
  TextStyle get welcomeText => FontStyles.welcomeText;
  TextStyle get questionText => FontStyles.questionText;
  TextStyle get amountTextLarge => FontStyles.amountTextLarge;
  TextStyle get amountTextMedium => FontStyles.amountTextMedium;
  TextStyle get nameStyle => FontStyles.nameStyle;
  TextStyle get defaultBold => FontStyles.defaultBold;
  TextStyle get moneyText => FontStyles.moneyText;
}

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  /// Shortcut for getting screen size using context.
  Size get screenSize => MediaQuery.of(this).size;
}

String capitalizeEachWord(String s) {
  if (s.isEmpty) return s;
  return s
      .split(' ')
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
      .join(' ');
}
