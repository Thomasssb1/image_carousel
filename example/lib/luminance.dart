import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:title_carousel/title_carousel.dart';
import 'constructors.dart';

class Luminance extends StatefulWidget {
  const Luminance({Key? key}) : super(key: key);

  @override
  State<Luminance> createState() => _LuminanceState();
}

class _LuminanceState extends State<Luminance> {
  // Put your unsplash access token here
  String accessToken = "";

  Future<List> fetchImages(String query) async {
    var url = Uri.https('api.unsplash.com', '/photos/random', {
      'client_id': accessToken,
      'query': query,
      'orientation': 'portrait',
      'count': '5',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var values = jsonDecode(utf8.decode(response.bodyBytes));
      return values;
    } else if (response.statusCode == 401) {
      throw Exception(
          'Invalid access token, you need to set the [accessToken] variable in example/lib/luminance.dart');
    } else {
      throw Exception('Failed to load images');
    }
  }

  var images = [];

  @override
  void initState() {
    super.initState();
    fetchImages("nature").then((value) => setState(() {
          images = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: Stack(children: [
      (images.isNotEmpty)
          ? TitleCarousel(
              images: List.generate(
                  images.length,
                  (index) => baseImage(
                        images[index]["urls"]["full"],
                        title: baseText("${images[index]["alt_description"]}\n",
                            isTitle: true,
                            fontSizeMulti: 0.5,
                            computeLuminance: true),
                        description: [],
                      )),
              threshold: 0.25,
            )
          : const Center(child: CircularProgressIndicator()),
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
