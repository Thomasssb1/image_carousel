/// The animation to be used when changing between images in a [TitledCarousel].
enum CarouselAnimation {
  /// Use no animation when swapping between [CarouselImage] widgets
  none,

  /// Fade between new [CarouselImage] widgets
  fade,

  /// Slide between new [CarouselImage] widgets from the right
  slide,

  /// Resize the new [CarouselImage] widgets from the center
  size,

  /// Scale tbe new [CarouselImage] widgets from the center
  scale,

  /// Rotate the new [CarouselImage] widgets from the center
  rotate
}
