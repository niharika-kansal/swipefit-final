import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:swipefit/Screens/homepage_screen.dart';


class UserAuthGate extends StatelessWidget {
  const UserAuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream:  FirebaseAuth.instance.authStateChanges(),   builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(), 
            ],
          );
        }

        return const HomepageScreen();  
      },);
  }
}