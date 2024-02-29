import 'package:flutter/material.dart'; 
import '../widgets/movies_slider.dart'; // Importing movies_slider.dart

class TVShowsScreen extends StatefulWidget {
  const TVShowsScreen({Key? key}) : super(key: key);

  @override
  State<TVShowsScreen> createState() => _TVShowsScreenState();
}

class _TVShowsScreenState extends State<TVShowsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), // Adding bouncing scroll physics
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildTVShowsCategorySection('Latest TV Shows'), // Building TV shows category section for latest TV shows
          ..._buildTVShowsCategorySection('Recommended TV Shows'), // Building TV shows category section for recommended TV shows
          ..._buildTVShowsCategorySection('Top Rated TV Shows'), // Building TV shows category section for top rated TV shows
          ..._buildTVShowsCategorySection('On The Air'), // Building TV shows category section for TV shows on the air
          ..._buildTVShowsCategorySection('Popular TV Shows'), // Building TV shows category section for popular TV shows
          ..._buildTVShowsCategorySection('Airing Today'), // Building TV shows category section for TV shows airing today
        ],
      ),
    );
  }

  List<Widget> _buildTVShowsCategorySection(String category) {
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
