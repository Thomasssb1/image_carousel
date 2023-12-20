import 'package:flutter/material.dart';

/// The properties of the text overlay
///
/// Apart from some custom properties, this class is identical to [Text]
class TextProperties {
  /// The text to be displayed
  final String text;

  /// The color of the text overlay when the image is dark
  final Color brightColor;

  /// The color of the text overlay when the image is light
  final Color darkColor;

  /// The color of the text overlay when [computeLuminance] is false
  final Color? color;

  /// Whether to compute the luminance of the image to determine the color of the text overlay
  ///
  /// If [computeLuminance] is false, [color] will be used
  final bool? computeLuminance;

  /// The alignment of the text overlay
  final TextAlign? textAlign;

  /// The padding of the text overlay
  final EdgeInsets? textPadding;

  /// The font size of the text overlay
  final double? fontSize;

  /// The font weight of the text overlay
  final FontWeight? fontWeight;

  /// The letter spacing of the text overlay
  final double? letterSpacing;

  /// The height of the text overlay
  final double? height;

  /// The properties of the text overlay
  ///
  /// Apart from some custom properties, this class is identical to [Text]
  const TextProperties(
    this.text, {
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
