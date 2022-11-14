import 'package:flutter/material.dart';

class TStyle {
  TStyle._();

  static const TextStyle titleHuge = TextStyle(fontSize: 40, height: 1.2);
  static const TextStyle titleBig = TextStyle(fontSize: 30, height: 1.2);
  static const TextStyle titleNormal = TextStyle(fontSize: 24);
  static const TextStyle titleSmall = TextStyle(fontSize: 18);
  static const TextStyle titleListItem =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle bodyBig = TextStyle(fontSize: 18);
  static const TextStyle bodyNormal = TextStyle(fontSize: 16, height: 1.0);

  static const TextStyle bodyUltraSmall = TextStyle(fontSize: 12);

  //From Wonder
  static TextStyle h1 = generate(sizePx: 64, heightPx: 62);
  static TextStyle h2 = generate(sizePx: 32, heightPx: 46);
  static TextStyle h3 =
      generate(sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  static TextStyle h4 =
      generate(sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  static TextStyle title1 = generate(sizePx: 16, heightPx: 26, spacingPc: 5);
  static TextStyle title2 = generate(sizePx: 14, heightPx: 16.38);

  static TextStyle body = generate(sizePx: 16, heightPx: 27);
  //late final TextStyle dropCase = copy(quoteFont, sizePx: 56, heightPx: 20);
  static TextStyle dropCase = generate(sizePx: 56, heightPx: 20);
  static TextStyle bodyBold =
      generate(sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  static TextStyle bodySmall = generate(sizePx: 14, heightPx: 23);
  static TextStyle bodySmallBold =
      generate(sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  static TextStyle generate({
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    String? fontFamily,
    FontWeight? weight,
  }) {
    return TextStyle(
      fontSize: sizePx,
      fontFamily: fontFamily,
      height: heightPx != null ? (heightPx / sizePx) : null,
      letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : null,
      fontWeight: weight,
    );
  }
  // static const TextStyle copy(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
  //   return style.copyWith(
  //       fontSize: sizePx,
  //       height: heightPx != null ? (heightPx / sizePx) : style.height,
  //       letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
  //       fontWeight: weight);
  // }
}
