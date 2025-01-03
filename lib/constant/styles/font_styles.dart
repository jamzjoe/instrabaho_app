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

  static const TextStyle appBarFont =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: demphasize);

  static const TextStyle instruction = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: secondaryColor);

  static const TextStyle noteStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: noteColor);

  static const TextStyle bodyStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: demphasize);

  static const TextStyle countStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: noteColor);

  static const TextStyle rankStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: hintColor);

  static const TextStyle subTitle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: demphasize);

  static const TextStyle hintStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: demphasize);
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
  TextStyle get hintStyle => FontStyles.hintStyle;
  TextStyle get countStyle => FontStyles.countStyle;
  TextStyle get rankStyle => FontStyles.rankStyle;
  TextStyle get subTitle => FontStyles.subTitle;
  TextStyle get bodyStyle => FontStyles.bodyStyle;
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
