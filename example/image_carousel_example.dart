import 'package:flutter/material.dart';
import '../lib/image_carousel.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  TextProperties baseText(String text, bool isTitle) => TextProperties(
        title: text,
        computeLuminance: true,
        brightColor: const Color.fromARGB(255, 195, 195, 195),
        darkColor: Color.fromARGB(255, 64, 64, 64),
        fontWeight: FontWeight.bold,
        fontSize: isTitle ? 30 : 20,
      );

  CarouselImage baseImage(
          String link, TextProperties title, TextProperties description) =>
      CarouselImage(
        image: link,
        fit: BoxFit.fitHeight,
        placeholder: Center(child: CircularProgressIndicator()),
        titleOverlay: title,
        childrenTextOverlay: [description],
      );

  final List<Map> images = const [
    {
      "name": "Swan",
      "src": "https://source.unsplash.com/b027q9eF3Yo.jpeg",
      "description": "An elegant swan simming in the lake"
    },
    {
      "name": "Robin",
      "src": "https://source.unsplash.com/6L-b2EmQ4gk.jpeg",
      "description": "A robin standing in the snow"
    },
    {
      "name": "Pelican",
      "src": "https://source.unsplash.com/1g87nfXZchU.jpeg",
      "description": "A pelican staning next to a tree"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ImageCarousel(
      images: List.generate(
          images.length,
          (index) => baseImage(
              images[index]["src"],
              baseText(images[index]["name"], true),
              baseText(images[index]["description"], false))),
    )));
  }
}
