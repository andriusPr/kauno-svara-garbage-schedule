import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ProxyFontSize { smallest, extraSmall, small, medium, large, extraLarge, huge, extraHuge }
enum ProxyFontWeight { regular, semiBold, bold, extraBold }
enum ProxySpacing { extraSmall, small, medium, large, extraLarge, huge }

class ProxyConstants {
  static const Map<ProxyFontSize, double> sizeVariants = {
    ProxyFontSize.smallest: 12.0,
    ProxyFontSize.extraSmall: 14.0,
    ProxyFontSize.small: 16.0,
    ProxyFontSize.medium: 18.0,
    ProxyFontSize.large: 20.0,
    ProxyFontSize.extraLarge: 24.0,
    ProxyFontSize.huge: 28.0,
    ProxyFontSize.extraHuge: 32.0,
  };

  static double getFontSize(ProxyFontSize value) => sizeVariants[value]!;

  static const Map<ProxyFontWeight, FontWeight> fontWeightVariants = {
    ProxyFontWeight.regular: FontWeight.w400,
    ProxyFontWeight.semiBold: FontWeight.w500,
    ProxyFontWeight.bold: FontWeight.w600,
    ProxyFontWeight.extraBold: FontWeight.w700,
  };

  static FontWeight getFontWeight(ProxyFontWeight value) => fontWeightVariants[value]!;

  static const Map<ProxySpacing, double> spacingVariants = {
    ProxySpacing.extraSmall: 5.0,
    ProxySpacing.small: 10.0,
    ProxySpacing.medium: 20.0,
    ProxySpacing.large: 30.0,
    ProxySpacing.extraLarge: 40.0,
    ProxySpacing.huge: 50.0,
  };

  static double getSpacing(ProxySpacing value) => spacingVariants[value]!;
}
