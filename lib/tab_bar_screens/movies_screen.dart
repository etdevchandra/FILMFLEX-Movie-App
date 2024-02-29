import 'package:flutter/material.dart'; 
import '../widgets/cinema_slider.dart'; // Importing cinema_slider.dart
import '../widgets/movies_slider.dart'; // Importing movies_slider.dart 

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), // Adding bouncing scroll physics
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildCinemaCategorySection('What are the best movies this year?'), // Building cinema category section for best movies
          ..._buildCinemaCategorySection('What are the highest-grossing movies of all time?'), // Building cinema category section for highest-grossing movies
          ..._buildMovieCategorySection('Upcoming Movies'), // Building movie category section for upcoming movies
          ..._buildMovieCategorySection('Recommended Movies'), // Building movie category section for recommended movies
          ..._buildMovieCategorySection('Top Rated Movies'), // Building movie category section for top rated movies
          ..._buildMovieCategorySection('Children Friendly Movies'), // Building movie category section for children friendly movies
        ],
      ),
    );
  }

  List<Widget> _buildCinemaCategorySection(String category) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, 
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      const SizedBox(height: 8),
      const cinemaSlider(), // Displaying cinema slider
    ];
  }

  List<Widget> _buildMovieCategorySection(String category) {
    return [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14, 
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      const SizedBox(height: 8),
      const moviesSlider(), // Displaying movies slider
    ];
  }
}
