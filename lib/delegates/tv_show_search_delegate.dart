import 'package:flutter/material.dart';
import 'package:filmflex_movie_application/api_service/api.dart';
import 'package:filmflex_movie_application/models/tv_shows.dart';
import 'package:filmflex_movie_application/constants.dart';

class TVShowSearchDelegate extends SearchDelegate<TVShows?> {
  final Api _api = Api();

  TVShowSearchDelegate() : super(searchFieldLabel: "Search by title or actor");

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
    return FutureBuilder<List<TVShows>>(
      future: _searchTVShows(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return _buildTVShowList(snapshot.data!);
        } else {
          return const Center(child: Text('No results found.'));
        }
      },
    );
  }

  Future<List<TVShows>> _searchTVShows(String query) async {
    List<TVShows> tvShows = await _api.searchTVShowsByTitle(query);
    if (tvShows.isEmpty) {
      tvShows = await _api.searchTVShowsByActor(query);
    }
    return tvShows;
  }

  Widget _buildTVShowList(List<TVShows> tvShows) {
    return ListView.builder(
      itemCount: tvShows.length,
      itemBuilder: (context, index) {
        final TVShows tvShow = tvShows[index];
        return ListTile(
          // ignore: unnecessary_null_comparison
          leading: tvShow.posterPath != null && tvShow.posterPath.isNotEmpty
              ? Image.network('${Constants.imagePath}${tvShow.posterPath}')
              : null,
          title: Text(tvShow.name),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 12.0),
              SizedBox(width: 4),
              Text('Rating: ${tvShow.voteAverage.toString()}'),
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
