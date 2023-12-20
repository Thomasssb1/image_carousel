import 'package:flutter/material.dart';
import 'package:image_carousel/image_carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  TextProperties baseText(String text, bool isTitle) => TextProperties(
      title: text,
      computeLuminance: true,
      brightColor: const Color.fromARGB(255, 195, 195, 195),
      darkColor: const Color.fromARGB(255, 64, 64, 64),
      fontWeight: FontWeight.bold,
      fontSize: isTitle ? 48 : 20,
      height: 1,
      textPadding: EdgeInsets.only(bottom: 500),
      textAlign: TextAlign.center);

  CarouselImage baseImage(
          String link, TextProperties title, TextProperties description) =>
      CarouselImage(
        image: link,
        fit: BoxFit.fitHeight,
        titleOverlay: title,
        childrenTextOverlay: [description],
        threshold: 0.25,
      );

  final List<Map> images = const [
    {
      "name": "Swan",
      "src": "https://source.unsplash.com/b027q9eF3Yo.jpeg",
      "description": "\nAn elegant swan simming in the lake"
    },
    {
      "name": "Robin",
      "src": "https://source.unsplash.com/6L-b2EmQ4gk.jpeg",
      "description": "\nA robin standing in the snow"
    },
    {
      "name": "Pelican",
      "src": "https://source.unsplash.com/1g87nfXZchU.jpeg",
      "description": "\nA pelican staning next to a tree"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: ImageCarousel(
      images: List.generate(
          images.length,
          (index) => baseImage(
                images[index]["src"],
                baseText(images[index]["name"], true),
                baseText(images[index]["description"], false),
              )),
    ))));
  }
}
