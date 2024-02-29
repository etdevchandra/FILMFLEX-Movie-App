import 'package:flutter/material.dart'; 
import 'package:carousel_slider/carousel_slider.dart'; // Importing carousel_slider package

class cinemaSlider extends StatelessWidget {
  const cinemaSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 10, // Number of items in the carousel
        options: CarouselOptions(
          height: 300, 
          autoPlay: true, // Auto play enabled
          viewportFraction: 0.55, // Fraction of viewport width each item should occupy
          enlargeCenterPage: true, // Enlarge the center item
          pageSnapping: true, // Snap to the item when scrolling
          autoPlayCurve: Curves.fastOutSlowIn, // Animation curve for auto play
          autoPlayAnimationDuration: const Duration(seconds: 1), // Duration for auto play animation
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20), // Rounded corners for the container
            child: Container(
              height: 300,
              width: 200,
              color: Colors.white, 
            ),
          );
        },
      ),
    );
  }
}