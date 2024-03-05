import 'package:flutter/material.dart';

import '../constants.dart'; 

class moviesSlider extends StatelessWidget {
  const moviesSlider({
    super.key, required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, 
      width: double.infinity, // Taking full width available
      child: ListView.builder(
        scrollDirection: Axis.horizontal, 
        physics: const BouncingScrollPhysics(), // Adding bouncing scroll physics
        itemCount: snapshot.data.length, // Placeholder item count
        itemBuilder: (context, item) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Rounded corners for the container
              child: SizedBox(
                height: 250, 
                width: 125, 
                child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  '${Constants.imagePath}${snapshot.data[item].posterPath}',
                ), 
              ),
            ),
          );
        },
      ),
    );
  }
}