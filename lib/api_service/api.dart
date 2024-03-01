import 'dart:convert';
import 'package:filmflex_movie_application/models/movies.dart';
import 'package:filmflex_movie_application/constants.dart';
import 'package:filmflex_movie_application/models/tv_shows.dart';
import 'package:http/http.dart' as http;


class Api {
  static const _nowPlayingMoviesUrl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}';
  static const _bestMoviesUrl =
      'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&release_date.gte=2024-01-01&release_date.lte&2024-03-01&sort_by=popularity.desc';   
  static const _highestGrossingMoviesUrl =
      'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&sort_by=revenue.desc';
  static const _upcomingMoviesUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  static const _popularMoviesUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}';
  static const _topRatedMoviesUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';
  static const _childrenFriendlyMoviesUrl =
      'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&certification_country=US&certification.lte=G&with_genres=16&include_adult=false&sort_by=popularity.desc';
  static const _airingTonightTVShowsUrl =
      'https://api.themoviedb.org/3/tv/airing_today?api_key=${Constants.apiKey}';
  static const _topRatedTVShowsUrl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=${Constants.apiKey}';
  static const _onTheAirTVShowsUrl =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=${Constants.apiKey}';
  static const _popularTVShowsUrl =
      'https://api.themoviedb.org/3/tv/popular?api_key=${Constants.apiKey}';
  static const _trendingTVShowsUrl =
      'https://api.themoviedb.org/3/trending/tv/week?api_key=${Constants.apiKey}';
  


  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse(_nowPlayingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load now playing movies at the cinema. Status code: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getBestMovies() async {
    final response = await http.get(Uri.parse(_bestMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load best movies this year. Status code: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getHighestGrossingMovies() async {
    final response = await http.get(Uri.parse(_highestGrossingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load highest grossing movies. Status code: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load upcoming movies. Status code: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(_popularMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load popular movies. Status code: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load top rated movies. Status code: ${response.statusCode}');
    }
  }

  Future<List<Movie>> getChildrenFriendlyMovies() async {
    final response = await http.get(Uri.parse(_childrenFriendlyMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load children-friendly movies. Status code: ${response.statusCode}');
    }
  }

  Future<List<TVShows>> getAiringTonightTVShows() async {
    final response = await http.get(Uri.parse(_airingTonightTVShowsUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvshows) => TVShows.fromJson(tvshows)).toList();
    } else {
      throw Exception('Failed to load whats on tv tonight. Status code: ${response.statusCode}');
    }
  }

  Future<List<TVShows>> getTopRatedTVShows() async {
    final response = await http.get(Uri.parse(_topRatedTVShowsUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvshows) => TVShows.fromJson(tvshows)).toList();
    } else {
      throw Exception('Failed to load top rated tv shows. Status code: ${response.statusCode}');
    }
  }

  Future<List<TVShows>> getTrendingTVShows() async {
    final response = await http.get(Uri.parse(_trendingTVShowsUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvshows) => TVShows.fromJson(tvshows)).toList();
    } else {
      throw Exception('Failed to load trending tv shows. Status code: ${response.statusCode}');
    }
  }

  Future<List<TVShows>> getPopularTVShows() async {
    final response = await http.get(Uri.parse(_popularTVShowsUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvshows) => TVShows.fromJson(tvshows)).toList();
    } else {
      throw Exception('Failed to load popular tv shows. Status code: ${response.statusCode}');
    }
  }

  Future<List<TVShows>> getOnTheAirTVShows() async {
    final response = await http.get(Uri.parse(_onTheAirTVShowsUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((tvshows) => TVShows.fromJson(tvshows)).toList();
    } else {
      throw Exception('Failed to load tv shows on the air. Status code: ${response.statusCode}');
    }
  }
  
}