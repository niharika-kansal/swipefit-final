import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipefit/Screens/cartpage_screen.dart';
import 'package:swipefit/Screens/homepage_screen.dart';
import 'package:swipefit/Screens/likepage_screen.dart';
import 'package:swipefit/Screens/productpage_screen.dart';
import 'package:swipefit/Screens/profile_screen.dart';
import 'package:swipefit/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swipefit/auth/login_page_screen.dart';
import 'package:swipefit/auth/login_page_screen.dart';
import 'package:swipefit/auth/signup_screen.dart';
import 'package:swipefit/components/quantity_updater.dart';
import 'firebase_options.dart';
import 'Screens/productpage_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
