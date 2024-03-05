import 'package:flutter/material.dart';
import '../widgets/movies_slider.dart';
import '../models/tv_shows.dart';
import 'package:filmflex_movie_application/api_service/api.dart';

class TVShowsScreen extends StatefulWidget {
  const TVShowsScreen({Key? key}) : super(key: key);

  @override
  State<TVShowsScreen> createState() => _TVShowsScreenState();
}

class _TVShowsScreenState extends State<TVShowsScreen> {
  late Future<List<TVShows>> airingTonightTVShows;
  late Future<List<TVShows>> topRatedTVShows;
  late Future<List<TVShows>> trendingTVShows;
  late Future<List<TVShows>> onTheAirTVShows;

  @override
  void initState() {
    super.initState();
    airingTonightTVShows = Api().getAiringTonightTVShows();
    topRatedTVShows = Api().getTopRatedTVShows();
    trendingTVShows = Api().getTrendingTVShows();
    onTheAirTVShows = Api().getOnTheAirTVShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shows On TV Tonight',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: FutureBuilder(
                  future: airingTonightTVShows,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return moviesSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Top Rated TV Shows',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: FutureBuilder(
                  future: topRatedTVShows,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return moviesSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Trending TV Shows',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: FutureBuilder(
                  future: trendingTVShows,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return moviesSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'On The Air TV Shows',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: FutureBuilder(
                  future: onTheAirTVShows,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return moviesSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
