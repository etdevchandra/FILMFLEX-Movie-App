import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:filmflex_movie_application/services/firebase_auth_methods.dart';
import 'package:filmflex_movie_application/main_screen.dart';
import 'package:filmflex_movie_application/user_screens/sign_up_screen.dart';
import 'package:filmflex_movie_application/user_screens/forgot_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    void _signInUser() async {
      final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      bool success = await authMethods.signInWithEmail(email: email, password: password, context: context);

      if (success) {
        if (rememberMe) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);
          await prefs.setString('password', password);
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    }

    void _signInWithGoogle() async {
      final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
      bool success = await authMethods.signInWithGoogle(context);
      if (success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    }

    void _navigateToForgotPassword() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/filmflex_logo.png', height: 48),
                ),
                const SizedBox(height: 34),
                Text(
                  'THE GATEWAY TO A CINEMATIC UNIVERSE.',
                  style: GoogleFonts.blackHanSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      height: 0.9,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Email'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration('Password'),
                ),
                CheckboxListTile(
                  title: Text("Remember me", style: TextStyle(color: Colors.white)),
                  value: rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _navigateToForgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 350,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _signInUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 190, 161, 1),
                      shape: RoundedRectangleBorder(),
                    ),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 62),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.white)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR', style: TextStyle(color: Colors.white, fontSize: 15,
                        fontWeight: FontWeight.bold)),
                    ),
                    Expanded(child: Divider(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 2),
                SignInButton(
                  Buttons.google,
                  text: "Sign in with Google",
                  onPressed: _signInWithGoogle,
                ),
                const SizedBox(height: 44),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SignUpScreen())),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
