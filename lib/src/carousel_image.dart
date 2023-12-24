import 'package:cached_network_image/cached_network_image.dart';

import '../src/title_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

/// The image and text content to be displayed within the [TitleCarousel]
// ignore: must_be_immutable
class CarouselImage extends StatelessWidget {
  /// The image to be displayed, this can be a network image or an asset image.
  final String image;

  /// The placeholder widget to be displayed whilst the network image is loading
  final Widget _placeholder;

  /// The fit of the image within the container
  final BoxFit? fit;

  /// The title overlay properties
  final TextProperties? titleOverlay;

  /// The children text overlay properties
  final List<TextProperties> _childrenTextOverlay;

  // determines whether to use the light or dark colour
  bool _useLightColour = false;

  /// The image and text content to be displayed within the [TitleCarousel]
  CarouselImage(
    this.image, {
    Key? key,
    Widget? placeholder,
    this.fit,
    this.titleOverlay,
    List<TextProperties>? childrenTextOverlay,
  })  : _placeholder = placeholder ?? Container(color: Colors.black),
        _childrenTextOverlay = childrenTextOverlay ?? [],
        super(key: key);

  void setLuminance(double threshold) async {
    final tp =
        TextPainter(text: _generateText(), textDirection: TextDirection.ltr);
    tp.layout();
    Map<String, int> textArea = {
      "width": tp.width.ceil(),
      "height": tp.height.ceil()
    };

    final Uint8List response = (isNetworkImage())
        ? (await http.get(Uri.parse(image))).bodyBytes
        : (await rootBundle.load(image)).buffer.asUint8List();

    final img.Image? decodedImage = img.decodeImage(response);
    double luminanceTotal = 0;
    if (decodedImage != null) {
      // Get the pixel data
      for (int y = 0; y < textArea["height"]!; y++) {
        for (int x = 0; x < textArea["width"]!; x++) {
          img.Pixel pixel = decodedImage.getPixel(x, y);
          luminanceTotal += pixel.luminanceNormalized;
        }
      }
    }
    _useLightColour =
        (luminanceTotal / (textArea["height"]! * textArea["width"]!) <
            threshold);
  }

  TextSpan _generateText() {
    return TextSpan(
        text: titleOverlay!.text,
        style: TextStyle(
          fontSize: titleOverlay!.fontSize,
          fontWeight: titleOverlay!.fontWeight,
          letterSpacing: titleOverlay!.letterSpacing,
          color: titleOverlay!.computeLuminance ?? false
              ? ((_useLightColour)
                  ? titleOverlay!.brightColor
                  : titleOverlay!.darkColor)
              : titleOverlay!.color,
          height: titleOverlay!.height,
        ),
        children: List.generate(
            _childrenTextOverlay.length,
            (index) => TextSpan(
                text: _childrenTextOverlay[index].text,
                style: TextStyle(
                  fontSize: _childrenTextOverlay[index].fontSize,
                  fontWeight: _childrenTextOverlay[index].fontWeight,
                  letterSpacing: _childrenTextOverlay[index].letterSpacing,
                  color: _childrenTextOverlay[index].computeLuminance ?? false
                      ? ((_useLightColour)
                          ? _childrenTextOverlay[index].brightColor
                          : _childrenTextOverlay[index].darkColor)
                      : _childrenTextOverlay[index].color,
                  height: _childrenTextOverlay[index].height,
                ))));
  }

  Color getLuminanceColour() =>
      _useLightColour ? titleOverlay!.brightColor : titleOverlay!.darkColor;

  List<TextProperties> getChildrenTextOverlay() => _childrenTextOverlay;

  bool isNetworkImage() {
    return Uri.parse(image).isScheme('HTTP') ||
        Uri.parse(image).isScheme('HTTPS');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      isNetworkImage()
          ? CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
              placeholder: (context, url) => _placeholder,
              errorWidget: (context, url, error) => _placeholder,
            )
          : Container(
              foregroundDecoration: BoxDecoration(
                  image: DecorationImage(fit: fit, image: AssetImage(image)))),
      if (titleOverlay != null)
        Padding(
            padding: titleOverlay?.textPadding ?? EdgeInsets.zero,
            child:
                Text.rich(textAlign: titleOverlay!.textAlign, _generateText()))
    ]);
  }
}
