import 'package:flutter/material.dart';
import 'package:filmflex_movie_application/delegates/movie_search_delegate.dart';
import 'package:filmflex_movie_application/delegates/tv_show_search_delegate.dart';
import 'package:filmflex_movie_application/tab_bar_screens/home_screen.dart';
import 'package:filmflex_movie_application/tab_bar_screens/movies_screen.dart';
import 'package:filmflex_movie_application/tab_bar_screens/tv_shows_screen.dart';
import 'package:filmflex_movie_application/tab_bar_screens/watch_later_screen.dart';
import 'package:filmflex_movie_application/user_screens/sign_in_screen.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 

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

  Future<void> _signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email'); 
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/filmflex_logo.png', fit: BoxFit.cover, height: 55),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchChoiceDialog(context),
          ),
          PopupMenuButton<int>(
            onSelected: (item) => _onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Sign Out')),
            ],
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

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        _signOut();
        break;
    }
  }
}
