import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'indicator.dart';
import 'carousel_image.dart';

class ImageCarousel extends StatefulWidget {
  final List<CarouselImage> images;
  final double? width;
  final Duration? duration;
  final BoxDecoration dDecoration;
  final Color selectedColor;
  final Widget? placeholder;
  final double threshold;

  ImageCarousel(
      {Key? key,
      required this.images,
      this.width = 300,
      this.duration = const Duration(seconds: 3),
      BoxDecoration? dotDecoration,
      this.selectedColor = Colors.red,
      this.placeholder,
      this.threshold = 0.3})
      : dDecoration = dotDecoration ??
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2 * pi),
                border: Border.all(color: Colors.black, width: 2)),
        super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late List<CarouselImage> images;
  late double width;
  late Duration duration;
  late BoxDecoration dDecoration;
  late Color selectedColor;
  late Widget? placeholder;
  late Color textColor;
  late double threshold;

  int _currentImage = 0;
  final double _gap = 10;
  bool _paused = false;
  List<Indicator> _dots = [];

  void _generateDots() {
    for (int i = 0; i < images.length; i++) {
      _dots.add(Indicator(selectedColour: selectedColor, dot: dDecoration));
      if (i == 0) _dots[0].setSelected(true);
    }
  }

  void _setAttributes() {
    images = widget.images;
    width = widget.width!;
    duration = widget.duration!;
    dDecoration = widget.dDecoration;
    selectedColor = widget.selectedColor;
    placeholder = widget.placeholder;
    threshold = widget.threshold;
  }

  void _changeImage() {
    setState(() {
      _dots[_currentImage].setSelected(false);
      _currentImage = (_currentImage + 1) % images.length;
      _dots[_currentImage].setSelected(true);
    });
  }

  void pause() {
    setState(() {
      _paused = true;
    });
  }

  void play() {
    setState(() {
      _paused = false;
    });
    _schedule();
  }

  void setTextColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  Timer _schedule() => Timer.periodic(duration, (timer) {
        if (_paused) {
          timer.cancel();
        } else {
          _changeImage();
        }
      });

  void _setLuminance() {
    for (int i = 0; i < images.length; i++) {
      if (images[i].titleOverlay != null &&
          images[i].titleOverlay!.computeLuminance!) images[i].setLuminance();
    }
  }

  @override
  void initState() {
    super.initState();
    _setAttributes();
    _generateDots();
    _schedule();
    _setLuminance();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      images[_currentImage],
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: width,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 200),
                  child: Row(
                      children: List.generate(_dots.length, (index) {
                    print("color: ${_dots[index].getDot().color}");
                    return Container(
                        margin: EdgeInsets.only(left: (index > 0) ? _gap : 0),
                        //duration: duration,
                        decoration: _dots[index].getDot(),
                        width: (width - ((images.length - 1) * _gap)) /
                            images.length,
                        height: 10);
                  })))))
    ]);
  }
}
