import 'package:flutter/material.dart';
import 'package:filmflex_movie_application/delegates/movie_search_delegate.dart';
import 'package:filmflex_movie_application/delegates/tv_show_search_delegate.dart';
import 'package:filmflex_movie_application/tab_bar_screens/home_screen.dart';
import 'package:filmflex_movie_application/tab_bar_screens/movies_screen.dart';
import 'package:filmflex_movie_application/tab_bar_screens/tv_shows_screen.dart';
import 'package:filmflex_movie_application/tab_bar_screens/watch_later_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSearchChoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black, 
          title: Text(
            'What are you searching for?',
            style: TextStyle(
              color: Colors.white, 
              fontSize: 18, 
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    'Movies',
                    style: TextStyle(
                      color: Colors.yellow, 
                      fontSize: 14, 
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the dialog
                    showSearch(context: context, delegate: MovieSearchDelegate());
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text(
                    'TV Shows',
                    style: TextStyle(
                      color: Colors.yellow, 
                      fontSize: 14, 
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the dialog
                    showSearch(context: context, delegate: TVShowSearchDelegate());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/filmflex_logo.png', fit: BoxFit.cover, height: 55),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchChoiceDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Need to implement menu action
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.yellow,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 12),
              tabs: const [
                Tab(text: 'HOME'),
                Tab(text: 'MOVIES'),
                Tab(text: 'TV SHOWS'),
                Tab(text: 'WATCH LATER'),
              ],
              isScrollable: true,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeScreen(),
          MoviesScreen(),
          TVShowsScreen(),
          WatchLaterScreen(),
        ],
      ),
    );
  }
}
