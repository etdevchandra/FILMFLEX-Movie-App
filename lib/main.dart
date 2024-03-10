import 'package:filmflex_movie_application/services/firebase_auth_methods.dart';
import 'package:filmflex_movie_application/user_screens/splash_screen.dart'; 
import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// ignore: unused_import
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuthMethods>(
      create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
      child: MaterialApp( 
        debugShowCheckedModeBanner: false, 
        title: 'FILMFLEX',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: SplashScreen(), 
      ),
    );
  }
}
