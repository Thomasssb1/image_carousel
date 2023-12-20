import 'package:flutter/material.dart';
import 'package:title_carousel/title_carousel.dart';
import 'package:go_router/go_router.dart';
import 'constructors.dart';

class NonLuminance extends StatefulWidget {
  const NonLuminance({Key? key}) : super(key: key);

  @override
  State<NonLuminance> createState() => _NonLuminanceState();
}

class _NonLuminanceState extends State<NonLuminance> {
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
                child: Stack(children: [
      TitleCarousel(
        images: List.generate(
            images.length,
            (index) => baseImage(
                  images[index]["src"],
                  title: baseText(images[index]["name"], isTitle: true),
                  description: [
                    baseText(images[index]["description"], isTitle: false)
                  ],
                )),
        threshold: 0.25,
      ),
      Positioned(
          top: 0,
          left: 0,
          child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios)))
    ]))));
  }
}
