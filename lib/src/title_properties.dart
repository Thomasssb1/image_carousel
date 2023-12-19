import 'package:flutter/material.dart';

class TextProperties {
  final String title;

  final Color brightColor;
  final Color darkColor;
  final Color? color;
  final bool? computeLuminance;

  final TextAlign? textAlign;
  final EdgeInsets? textPadding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? height;

  const TextProperties({
    required this.title,
    this.brightColor = Colors.white,
    this.darkColor = Colors.black,
    this.computeLuminance = false,
    this.color,
    this.textPadding,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
  });
}
