import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final List<Widget> children;
  final double height;
  final bool autoPlay;
  final bool enlargeCenterPage;
  const CarouselWidget({
    super.key,
    required this.children,
    this.height = 200.0,
    this.autoPlay = false,
    this.enlargeCenterPage = true,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: children,
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        enlargeCenterPage: enlargeCenterPage,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
    );
    ;
  }
}
