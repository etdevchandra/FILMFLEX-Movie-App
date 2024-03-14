import 'package:flutter/material.dart';
import 'package:filmflex_movie_application/api_service/api.dart';
import 'package:filmflex_movie_application/models/movies.dart';
import 'package:filmflex_movie_application/constants.dart';

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  final Api _api = Api();

  MovieSearchDelegate() : super(searchFieldLabel: "Search by title or actor");

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return _buildMovieList(snapshot.data!);
        } else {
          return const Center(child: Text('No results found.'));
        }
      },
    );
  }

  Future<List<Movie>> _searchMovies(String query) async {
    List<Movie> movies = await _api.searchMoviesByTitle(query);
    if (movies.isEmpty) {
      movies = await _api.searchMoviesByActor(query);
    }
    return movies;
  }

  Widget _buildMovieList(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          // ignore: unnecessary_null_comparison
          leading: movie.posterPath != null && movie.posterPath.isNotEmpty
              ? Image.network('${Constants.imagePath}${movie.posterPath}')
              : null,
          title: Text(movie.title),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 12.0),
              SizedBox(width: 4),
              Text('Rating: ${movie.voteAverage.toString()}'),
            ],
          ),
          onTap: () {
            
          },
        );
      },
    );
  }

  @override
Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
