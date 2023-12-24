Flutter image carousel component which can be used to create multiple rotating images within a single component using either network or local images. This carousel can also add text overlay along with automatically determined text colour based on the image brightness.

<!--
## Features
A unique feature of this component is that you can allow the text that is displayed on the image to have its colour changed based off pixel luminance where it will be written.
TODO: add an image showing how it works as well as the calculation behind it
-->

## Installation

To get started, you will need to add the following in the `pubspec.yaml` of your flutter project

```yaml
dependencies:
  flutter:
    sdk:
  title_carousel: any
```

Import the package like so

```dart
import 'package:title_carousel/title_carousel.dart';
```

## Usage

To add a `TitleCarousel` to your project, you can use the widget like normal in your widget tree with the images supplied using the `CarouselImage` class.

```dart
TitleCarousel(
  images: [
    CarouselImage(image: "https://source.unsplash.com/b027q9eF3Yo.jpeg"),
    CarouselImage(image: "https://source.unsplash.com/6L-b2EmQ4gk.jpeg"),
    CarouselImage(image: "https://source.unsplash.com/6L-b2EmQ4gk.jpeg")
  ]
)
```

This will create a simple image carousel with all default values - switching between the 3 images cyclically.

---

To add text to your image - you need to pass the `TextProperties` class to the corresponding overlay within your `CarouselImage`.

```dart
CarouselImage(
  image: "https://source.unsplash.com/b027q9eF3Yo.jpeg",
  titleOverlay: TextProperties(title: "Swan\n", computeLuminance: true),
  childrenTextOverlay: [
    TextProperties("An elegant swan swimming in the lake", computeLuminance: true)
  ]
)
```

For each `TextProperties` object you can use luminance to influence the text colour used by setting `computeLuminance` to true. You can also customise the colours used by changing the `brightColor` and `darkColor` attributes.
This class also contains the same attributes as a `Text` object - so you can customise the text however you like.<br><br>
_Want to customise the indicator dots shown on the carousel?_<br>
`TitleCarousel` takes the `dotDecoration` argument which allows for you to style the indicator however you like - you can even change the `selectedColor` to any color for when the current dot is active!<br><br>

## Example
You can view an example under the `examples/` directory, which is a flutter app showing the functionality of both non-luminous calculation and luminous calculation for text colour. The non-luminous example shows a set of pre-determined networked images whilst the luminous example will fetch random images from unsplash. To try the luminous example, you will need to add your unsplash `accessToken` to the variable inside of `examples/lib/luminance.dart`.

Something to note, is that because the colours you can pass is binary as it is based off luminosity - it may not always be as effective as using something like K-means to determine the most dominant colour but this will give you the best colour based on the brightness at that location.

<!--
## Additional information
Want to see it in action? I used it in my own [app]()
-->
