/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/forgot_password_img.jpg
  AssetGenImage get forgotPasswordImg =>
      const AssetGenImage('assets/images/forgot_password_img.jpg');

  /// File path: assets/images/instrabaho_logo.png
  AssetGenImage get instrabahoLogo =>
      const AssetGenImage('assets/images/instrabaho_logo.png');

  /// File path: assets/images/onboarding_1.jpg
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding_1.jpg');

  /// File path: assets/images/onboarding_2.jpg
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding_2.jpg');

  /// File path: assets/images/onboarding_3.jpg
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding_3.jpg');

  /// File path: assets/images/onboarding_4.jpg
  AssetGenImage get onboarding4 =>
      const AssetGenImage('assets/images/onboarding_4.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        forgotPasswordImg,
        instrabahoLogo,
        onboarding1,
        onboarding2,
        onboarding3,
        onboarding4
      ];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/instrabaho-splash copy.json
  String get instrabahoSplashCopy => 'assets/json/instrabaho-splash copy.json';

  /// List of all assets
  List<String> get values => [instrabahoSplashCopy];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/coins.svg
  String get coins => 'assets/svg/coins.svg';

  /// File path: assets/svg/custom_back_btn.svg
  String get customBackBtn => 'assets/svg/custom_back_btn.svg';

  /// File path: assets/svg/custom_back_button.svg
  String get customBackButton => 'assets/svg/custom_back_button.svg';

  /// File path: assets/svg/instrabaho_logo.svg
  String get instrabahoLogo => 'assets/svg/instrabaho_logo.svg';

  /// File path: assets/svg/job_seeker_human.svg
  String get jobSeekerHuman => 'assets/svg/job_seeker_human.svg';

  /// File path: assets/svg/recruiter_human.svg
  String get recruiterHuman => 'assets/svg/recruiter_human.svg';

  /// List of all assets
  List<String> get values => [
        coins,
        customBackBtn,
        customBackButton,
        instrabahoLogo,
        jobSeekerHuman,
        recruiterHuman
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
