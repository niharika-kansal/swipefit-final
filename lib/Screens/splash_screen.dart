import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipefit/Screens/homepage_screen.dart';
import 'dart:async';
import 'package:swipefit/Screens/initial_signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Automatically navigate to LoginSignUpScreen after 3 seconds with a fade transition
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      final targetScreen =
          user != null ? HomepageScreen() : LoginSignUpScreen();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade transition
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });

    return Scaffold(
      backgroundColor:
          const Color(0xFFAF5179), // Background color as per design
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/main_logo.png',
              width:
                  MediaQuery.of(context).size.width * 0.36, // Responsive width
            ),
            Text(
              'SwipeFit',
              style: GoogleFonts.dancingScript(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
