import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'carousel_image.dart';

class TitleCarousel extends StatefulWidget {
  final List<CarouselImage> images;
  final double? width;
  final Duration? duration;
  final BoxDecoration dDecoration;
  final Color selectedColor;
  final Widget? placeholder;
  final double threshold;
  final EdgeInsets? indicatorPadding;

  TitleCarousel(
      {Key? key,
      required this.images,
      this.width = 300,
      this.duration = const Duration(seconds: 3),
      BoxDecoration? dotDecoration,
      this.selectedColor = Colors.red,
      this.placeholder,
      this.threshold = 0.3,
      this.indicatorPadding = const EdgeInsets.only(bottom: 200)})
      : dDecoration = dotDecoration ??
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2 * pi),
                border: Border.all(color: Colors.black, width: 2)),
        super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState(
      images: images,
      width: width!,
      duration: duration!,
      dDecoration: dDecoration,
      selectedColor: selectedColor,
      placeholder: placeholder,
      threshold: threshold,
      indicatorPadding: indicatorPadding!);
}

class _ImageCarouselState extends State<TitleCarousel> {
  late List<CarouselImage> images;
  late double width;
  late Duration duration;
  late BoxDecoration dDecoration;
  late Color selectedColor;
  late Widget? placeholder;
  late Color textColor;
  late double threshold;
  late EdgeInsets indicatorPadding;

  int _currentImage = 0;
  final double _gap = 10;
  bool _paused = false;
  List<_Indicator> _dots = [];

  _ImageCarouselState(
      {required this.images,
      required this.width,
      required this.duration,
      required this.dDecoration,
      required this.selectedColor,
      required this.placeholder,
      required this.threshold,
      required this.indicatorPadding});

  void _generateDots() {
    for (int i = 0; i < images.length; i++) {
      _dots.add(_Indicator(selectedColour: selectedColor, dot: dDecoration));
      if (i == 0) _dots[0].setSelected(true);
    }
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
        print("timer: ${timer.tick}");
        if (_paused) {
          timer.cancel();
        } else {
          _changeImage();
        }
      });

  /*void _setLuminance() async {
    for (int i = 0; i < images.length; i++) {
      if (images[i].titleOverlay != null &&
          images[i].titleOverlay!.computeLuminance!)
        print("set luminance: ${images[i].key}");
      await images[i].setLuminance(threshold).then((value) {
        setState(() {});
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    _generateDots();
    _schedule();
    //_setLuminance();
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
                  padding: indicatorPadding,
                  child: Row(
                      children: List.generate(_dots.length, (index) {
                    return AnimatedContainer(
                      margin: EdgeInsets.only(left: (index > 0) ? _gap : 0),
                      duration: duration,
                      decoration: _dots[index].getDot(),
                      width: ((width - ((images.length - 1) * _gap)) /
                              (images.length + 0.5)) *
                          ((index == _currentImage) ? 1.5 : 1),
                      height: 10,
                    );
                  })))))
    ]);
  }
}

class _Indicator {
  late BoxDecoration _dot;
  late Color _unselectedColour;
  late Color _selectedColour;

  void setSelected(bool selected) {
    print(
        "selected: $selected, colour: ${_selectedColour}, ${_unselectedColour}, ${_dot.color}");
    _dot = _dot.copyWith(color: selected ? _selectedColour : _unselectedColour);
  }

  BoxDecoration getDot() => _dot;

  _Indicator({required Color selectedColour, required BoxDecoration dot}) {
    _selectedColour = selectedColour;
    _unselectedColour = dot.color!;
    _dot = dot;
  }
}
