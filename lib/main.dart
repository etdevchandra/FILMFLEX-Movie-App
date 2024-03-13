import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:filmflex_movie_application/controller/dependency_injection.dart';
import 'package:filmflex_movie_application/controller/network_controller.dart';
import 'package:filmflex_movie_application/services/firebase_auth_methods.dart';
import 'package:filmflex_movie_application/user_screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  
  DependencyInjection.init();

  
  final NetworkController networkController = Get.put(NetworkController(), permanent: true);
  await networkController.checkInitialConnectivity();

  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuthMethods>(
      create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
      child: GetMaterialApp(
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
