import 'package:flutter/material.dart'; 
// Import screens for Movies, TV Shows, and Watch Later 
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
    _tabController = TabController(length: 4, vsync: this); // Initialize TabController with 4 tabs
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the AppBar background to black
        title: Image.asset(
          'assets/filmflex_logo.png', 
          fit: BoxFit.cover,
          height: 55,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Need to implement search action
            },
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
              indicatorColor: Colors.yellow, // Set the indicator (underline) to yellow
              labelColor: Colors.white, // Set the label color for selected tab to white
              labelStyle: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold, // Bold text for selected tab
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 12, 
              ),
              tabs: const [
                Tab(text: 'HOME'),
                Tab(text: 'MOVIES'),
                Tab(text: 'TV SHOWS'),
                Tab(text: 'WATCH LATER'),
              ],
              isScrollable: true, // Set to false to stretch tabs across the screen
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Placeholder for respective screens
          HomeScreen(), 
          MoviesScreen(), 
          TVShowsScreen(), 
          WatchLaterScreen(), 
        ],
      ),
    );
  }
}
