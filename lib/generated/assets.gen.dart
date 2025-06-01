/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

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

  /// File path: assets/icons/hourglass.png
  AssetGenImage get hourglass =>
      const AssetGenImage('assets/icons/hourglass.png');

  /// File path: assets/icons/ic_antiem.png
  AssetGenImage get icAntiem =>
      const AssetGenImage('assets/icons/ic_antiem.png');

  /// File path: assets/icons/ic_anuong_color.png
  AssetGenImage get icAnuongColor =>
      const AssetGenImage('assets/icons/ic_anuong_color.png');

  /// File path: assets/icons/ic_anuong_vip.png
  AssetGenImage get icAnuongVip =>
      const AssetGenImage('assets/icons/ic_anuong_vip.png');

  /// File path: assets/icons/ic_eye_off.svg
  SvgGenImage get icEyeOff => const SvgGenImage('assets/icons/ic_eye_off.svg');

  /// File path: assets/icons/location.png
  AssetGenImage get location =>
      const AssetGenImage('assets/icons/location.png');

  /// File path: assets/icons/plan.png
  AssetGenImage get plan => const AssetGenImage('assets/icons/plan.png');

  /// List of all assets
  List<dynamic> get values => [
        hourglass,
        icAntiem,
        icAnuongColor,
        icAnuongVip,
        icEyeOff,
        location,
        plan
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/default_avatar.png
  AssetGenImage get defaultAvatar =>
      const AssetGenImage('assets/images/default_avatar.png');

  /// File path: assets/images/default_cover.png
  AssetGenImage get defaultCover =>
      const AssetGenImage('assets/images/default_cover.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_4x.png
  AssetGenImage get logo4x => const AssetGenImage('assets/images/logo_4x.png');

  /// File path: assets/images/splash_image.png
  AssetGenImage get splashImage =>
      const AssetGenImage('assets/images/splash_image.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [defaultAvatar, defaultCover, logo, logo4x, splashImage];
}

class $AssetsSvgIconsGen {
  const $AssetsSvgIconsGen();

  /// File path: assets/svg_icons/favorite.svg
  SvgGenImage get favorite =>
      const SvgGenImage('assets/svg_icons/favorite.svg');

  /// File path: assets/svg_icons/home_page.svg
  SvgGenImage get homePage =>
      const SvgGenImage('assets/svg_icons/home_page.svg');

  /// File path: assets/svg_icons/my_plan.svg
  SvgGenImage get myPlan => const SvgGenImage('assets/svg_icons/my_plan.svg');

  /// File path: assets/svg_icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/svg_icons/profile.svg');

  /// List of all assets
  List<SvgGenImage> get values => [favorite, homePage, myPlan, profile];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgIconsGen svgIcons = $AssetsSvgIconsGen();
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

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
