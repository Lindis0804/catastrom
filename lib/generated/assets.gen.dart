/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Muli-Bold.ttf
  String get muliBold => 'assets/fonts/Muli-Bold.ttf';

  /// File path: assets/fonts/Muli-ExtraBold.ttf
  String get muliExtraBold => 'assets/fonts/Muli-ExtraBold.ttf';

  /// File path: assets/fonts/Muli-Medium.ttf
  String get muliMedium => 'assets/fonts/Muli-Medium.ttf';

  /// File path: assets/fonts/Muli-Regular.ttf
  String get muliRegular => 'assets/fonts/Muli-Regular.ttf';

  /// File path: assets/fonts/Muli-SemiBold.ttf
  String get muliSemiBold => 'assets/fonts/Muli-SemiBold.ttf';

  /// List of all assets
  List<String> get values =>
      [muliBold, muliExtraBold, muliMedium, muliRegular, muliSemiBold];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_antiem.png
  AssetGenImage get icAntiem =>
      const AssetGenImage('assets/icons/ic_antiem.png');

  /// File path: assets/icons/ic_anuong_color.png
  AssetGenImage get icAnuongColor =>
      const AssetGenImage('assets/icons/ic_anuong_color.png');

  /// File path: assets/icons/ic_anuong_vip.png
  AssetGenImage get icAnuongVip =>
      const AssetGenImage('assets/icons/ic_anuong_vip.png');

  /// List of all assets
  List<AssetGenImage> get values => [icAntiem, icAnuongColor, icAnuongVip];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/splash_image.png
  AssetGenImage get splashImage =>
      const AssetGenImage('assets/images/splash_image.png');
  AssetGenImage get logoImage => const AssetGenImage('assets/images/logo.png');
  AssetGenImage get logoImage4x =>
      const AssetGenImage('assets/images/logo_4x.png');
  AssetGenImage get plan => const AssetGenImage('assets/images/plan.png');
  AssetGenImage get location =>
      const AssetGenImage('assets/images/location.png');
  AssetGenImage get hourglass =>
      const AssetGenImage('assets/images/hourglass.png');

  /// List of all assets
  List<AssetGenImage> get values => [splashImage];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
