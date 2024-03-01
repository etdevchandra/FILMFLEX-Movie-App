import 'package:filmflex_movie_application/main_screen.dart'; 
import 'package:flutter/material.dart'; 

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'FILMFLEX', // Setting app title
      theme: ThemeData.dark().copyWith( 
        scaffoldBackgroundColor: Colors.black, // Setting scaffold background color
      ),
      home: const MainScreen(), // Setting MainScreen widget as home screen
    );
  }
}