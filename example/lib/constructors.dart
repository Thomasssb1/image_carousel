import 'package:flutter/material.dart';
import 'package:title_carousel/title_carousel.dart';

TextProperties baseText(String text,
        {bool isTitle = true,
        bool computeLuminance = false,
        double fontSizeMulti = 1}) =>
    TextProperties(text,
        computeLuminance: computeLuminance,
        brightColor: const Color.fromARGB(255, 195, 195, 195),
        darkColor: const Color.fromARGB(255, 64, 64, 64),
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: (isTitle ? 48 : 20) * fontSizeMulti,
        height: 1,
        textPadding: const EdgeInsets.only(bottom: 500),
        textAlign: TextAlign.center);

CarouselImage baseImage(String link,
        {TextProperties? title, List<TextProperties>? description}) =>
    CarouselImage(link,
        fit: BoxFit.fitHeight,
        titleOverlay: title,
        childrenTextOverlay: description);
