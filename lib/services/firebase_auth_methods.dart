import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:filmflex_movie_application/showSnackBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  bool isEmailDomainValid(String email) {
    List<String> commonDomains = [
      'gmail.com',
      'yahoo.com',
      'outlook.com',
      'hotmail.com'
    ];

    String domain = email.split('@').last;

    return commonDomains.contains(domain);
  }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required BuildContext context,
  }) async {
    if (password != confirmPassword) {
      showSnackBar(context, "Passwords do not match.");
      return false;
    }

    if (!EmailValidator.validate(email)) {
      showSnackBar(context, "Invalid email format.");
      return false;
    }

    if (!isEmailDomainValid(email)) {
      showSnackBar(context, "Please use a valid email domain.");
      return false;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();
      showSnackBar(context, "Signup successful. Please verify your email.");
      return true; 
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); 
      return false; 
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        showSnackBar(context, "Please verify your email before signing in.");
        return false;
      }
      return true; 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showSnackBar(context, "Incorrect email or password.");
      } else {
        showSnackBar(context, "An error occurred. Please try again later.");
      }
      return false; 
    }
  }

  Future<void> resendEmailVerification(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        showSnackBar(context, "Verification email resent. Please check your inbox.");
      } catch (e) {
        showSnackBar(context, "Error resending verification email: ${e.toString()}");
      }
    } else {
      showSnackBar(context, "User not found or already verified.");
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
          }
          showSnackBar(context, "Google sign-in successful.");
          return true; 
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); 
    } catch (e) {
      showSnackBar(context, "Failed to sign in with Google: ${e.toString()}");
    }
    return false; 
  }

  Future<bool> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    if (!EmailValidator.validate(email)) {
      showSnackBar(context, "Invalid email format.");
      return false;
    }

    if (!isEmailDomainValid(email)) {
      showSnackBar(context, "Please use a valid email address.");
      return false;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Password reset email sent.');
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      return false;
    }
  }


}
