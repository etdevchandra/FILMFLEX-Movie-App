import 'package:flutter/material.dart'; 

class moviesSlider extends StatelessWidget {
  const moviesSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, 
      width: double.infinity, // Taking full width available
      child: ListView.builder(
        scrollDirection: Axis.horizontal, 
        physics: const BouncingScrollPhysics(), // Adding bouncing scroll physics
        itemCount: 20, // Placeholder item count
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Rounded corners for the container
              child: Container(
                height: 250, 
                width: 125, 
                color: Colors.white, 
              ),
            ),
          );
        },
      ),
    );
  }
}
