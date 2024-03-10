import 'package:filmflex_movie_application/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:filmflex_movie_application/services/firebase_auth_methods.dart';
import 'package:filmflex_movie_application/user_screens/reset_password_screen.dart';
import 'package:filmflex_movie_application/user_screens/sign_in_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({Key? key}) : super(key: key);

  void _resetPassword(BuildContext context) async {
    final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
    bool success = await authMethods.resetPassword(
      email: emailController.text.trim(),
      context: context,
    );
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(emailAddress: emailController.text.trim()),
        ),
      );
    } else {
      showSnackBar(context, "Failed to send reset email. Make sure the email is correct.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1), 
                Image.asset('assets/email_icon.png', height: 120), 
                SizedBox(height: 20),
                Text(
                  'Forgot Your Password?',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Enter your email address to reset your password:',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 52),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 190, 161, 1),
                    minimumSize: Size(350, 45),
                    shape: RoundedRectangleBorder( 
                        borderRadius: BorderRadius.circular(0), 
                      ),
                  ),
                  onPressed: () => _resetPassword(context),
                  child: Text(
                    'Reset',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 132), 
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SignInScreen())),
                    child: RichText(
                      text: TextSpan(
                        text: 'Go back to ',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
