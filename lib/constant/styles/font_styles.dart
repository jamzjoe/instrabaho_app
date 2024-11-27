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

  static const TextStyle appBarFont = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 46.38 / 34, // line-height / font-size
      textBaseline: TextBaseline.alphabetic,
      decorationStyle: TextDecorationStyle.solid);

  static const TextStyle instruction = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: secondaryColor);

  static const TextStyle noteStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: noteColor);
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
}

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  /// Shortcut for getting screen size using context.
  Size get screenSize => MediaQuery.of(this).size;
}
