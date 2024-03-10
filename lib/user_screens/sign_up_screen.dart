import 'package:filmflex_movie_application/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:filmflex_movie_application/services/firebase_auth_methods.dart';
import 'package:filmflex_movie_application/user_screens/email_verification_screen.dart';
import 'package:filmflex_movie_application/user_screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _signUpUser(BuildContext context) async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text != _passwordController.text ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty) {
      showSnackBar(context, "Please fill in all fields and make sure the passwords match.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
    final signUpSuccess = await authMethods.signUpWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      context: context,
    );

    if (signUpSuccess) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const EmailVerificationScreen()),
      );
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/filmflex_logo.png', height: 48),
                const SizedBox(height: 32),
                Text(
                  'Sign Up',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                _buildTextField(_firstNameController, 'First Name'),
                const SizedBox(height: 16),
                _buildTextField(_lastNameController, 'Last Name'),
                const SizedBox(height: 16),
                _buildTextField(_emailController, 'Email'),
                const SizedBox(height: 16),
                _buildTextField(_passwordController, 'Password', isPassword: true),
                const SizedBox(height: 16),
                _buildTextField(_confirmPasswordController, 'Confirm Password', isPassword: true),
                const SizedBox(height: 24),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, 
                            backgroundColor: Color.fromARGB(255, 190, 161, 1),
                            minimumSize: const Size(350, 45), 
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(0), 
                            ),
                          ),
                          onPressed: () => _signUpUser(context),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 52),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SignInScreen())),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
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

  Widget _buildTextField(TextEditingController controller, String label, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
      ),
    );
  }
}
