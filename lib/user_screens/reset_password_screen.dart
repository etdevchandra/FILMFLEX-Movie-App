import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:filmflex_movie_application/user_screens/sign_in_screen.dart';
import 'package:filmflex_movie_application/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String emailAddress;

  ResetPasswordScreen({Key? key, required this.emailAddress}) : super(key: key);

  void _resendEmail(BuildContext context) {
    final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
    authMethods.resendEmailVerification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset('assets/email_icon.png', height: 100), 
              SizedBox(height: 32),
              Text(
                'Check Your Email',
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
                'A reset password link will be sent to your email address only if it is associated with an existing account. Please click on the link to reset your password.',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 190, 161, 1),
                  minimumSize: Size(350, 45), 
                  shape: RoundedRectangleBorder( 
                        borderRadius: BorderRadius.circular(0), 
                      ),
                ),
                onPressed: () => _resendEmail(context),
                child: Text(
                  'Resend Email',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
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
    );
  }
}
