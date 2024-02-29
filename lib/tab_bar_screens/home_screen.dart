import 'package:flutter/material.dart'; 
import '../widgets/cinema_slider.dart'; // Importing cinema_slider.dart
import '../widgets/movies_slider.dart'; // Importing movies_slider.dart

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), // Adding bouncing scroll physics
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildCinemaSection(), // Section for What's on at the Cinema? 
          ..._buildTVSection(), // Section for What's on TV tonight? 
        ],
      ),
    );
  }

  List<Widget> _buildCinemaSection() {
    return [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          'What’s on at the Cinema?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, 
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      const cinemaSlider(), // Displaying cinema slider
    ];
  }

  List<Widget> _buildTVSection() {
    return [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'What’s on TV tonight?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, 
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      const cinemaSlider(), // Displaying cinema slider

      const SizedBox(height: 32), // Adding space between sections
      Text(
        'Top Rated Movies',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14, 
          fontStyle: FontStyle.normal,
        ),
      ),
      const SizedBox(height: 32), // Adding space between sections
      const moviesSlider(), // Displaying movies slider

      const SizedBox(height: 32), // Adding space between sections
      Text(
        'Top Rated TV Shows',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14, 
          fontStyle: FontStyle.normal,
        ),
      ),
      const SizedBox(height: 32), // Adding space between sections
      const moviesSlider(), // Displaying movies slider
    ];
  }
}
