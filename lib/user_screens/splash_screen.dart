import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Don't forget to import shared_preferences
import 'package:filmflex_movie_application/user_screens/sign_in_screen.dart';
import 'package:filmflex_movie_application/main_screen.dart'; // Assuming this is the screen for signed-in users

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    // Optionally keep the delay to simulate loading or splash screen display time
    await Future.delayed(Duration(seconds: 3));
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    Widget nextScreen = email != null ? MainScreen() : SignInScreen(); // Decide next screen based on "Remember Me"
    
    // Using Navigator.pushReplacement to ensure we don't go back to the splash screen
    Navigator.of(context).pushReplacement(_createRoute(nextScreen));
  }

  Route _createRoute(Widget nextScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/filmflex_logo.png'), // Display your logo or any splash screen content
      ),
    );
  }
}
