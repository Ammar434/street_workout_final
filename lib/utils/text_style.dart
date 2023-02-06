import 'dart:ui';

import 'package:flutter/material.dart';

class TextThemeProvider {
  final double _scale = 1;

  final Map<String, TextStyle> _titleFonts = {
    'en': const TextStyle(fontFamily: 'Tenor'),
  };

  final Map<String, TextStyle> _monoTitleFonts = {
    'en': const TextStyle(fontFamily: 'B612Mono'),
  };

  final Map<String, TextStyle> _quoteFonts = {
    'en': const TextStyle(fontFamily: 'Cinzel'),
  };

  final Map<String, TextStyle> _wonderTitleFonts = {
    'en': const TextStyle(fontFamily: 'Yeseva'),
  };

  final Map<String, TextStyle> _contentFonts = {
    'en': const TextStyle(fontFamily: 'Raleway', fontFeatures: [
      FontFeature.enable('kern'),
    ]),
  };
  TextStyle get titleFont => _getFontForLocale(_titleFonts);
  TextStyle get quoteFont => _getFontForLocale(_quoteFonts);
  TextStyle get wonderTitleFont => _getFontForLocale(_wonderTitleFonts);
  TextStyle get contentFont => _getFontForLocale(_contentFonts);
  TextStyle get monoTitleFont => _getFontForLocale(_monoTitleFonts);

  late final TextStyle dropCase = _createFont(quoteFont, sizePx: 56, heightPx: 20);

  late final TextStyle appTitle = _createFont(wonderTitleFont, sizePx: 64, heightPx: 56);

  late final h1 = _createFont(titleFont, sizePx: 64, heightPx: 62);
  late final h2 = _createFont(titleFont, sizePx: 32, heightPx: 46);
  late final h3 = _createFont(titleFont, sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late final h4 = _createFont(titleFont, sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  late final title1 = _createFont(titleFont, sizePx: 20, heightPx: 32, spacingPc: 5, weight: FontWeight.w600);
  late final title2 = _createFont(titleFont, sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  late final body = _createFont(contentFont, sizePx: 16, heightPx: 26);
  late final bodyBold = _createFont(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  late final bodySmall = _createFont(contentFont, sizePx: 14, heightPx: 23);
  late final bodySmallBold = _createFont(contentFont, sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  late final quote1 = _createFont(quoteFont, sizePx: 32, heightPx: 40, weight: FontWeight.w600, spacingPc: -3);
  late final quote2 = _createFont(quoteFont, sizePx: 21, heightPx: 32, weight: FontWeight.w400);
  late final quote2Sub = _createFont(body, sizePx: 16, heightPx: 40, weight: FontWeight.w400);

  late final caption = _createFont(contentFont, sizePx: 14, heightPx: 20, weight: FontWeight.w500).copyWith(fontStyle: FontStyle.italic);

  late final callout = _createFont(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600).copyWith(fontStyle: FontStyle.italic);
  late final btn = _createFont(contentFont, sizePx: 16, weight: FontWeight.w700, spacingPc: 2, heightPx: 14);

  TextStyle _getFontForLocale(Map<String, TextStyle> fonts) {
    return fonts.entries.first.value;
  }

  TextStyle _createFont(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }
    return style.copyWith(
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : style.height,
      letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
      fontWeight: weight,
    );
  }
}
