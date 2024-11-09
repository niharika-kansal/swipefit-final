import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:swipefit/Screens/initial_signup_screen.dart';
import 'package:swipefit/components/bottom_navbar.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:swipefit/components/swiping_component.dart';
import 'package:swipefit/networking/network_helper.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int selected = 0;
  Map<String, dynamic>? response; // Make it nullable and remove late
  bool isLoading = true; // Add loading state
  NetworkHelper networkHelper =
      NetworkHelper(url: 'https://dummyjson.com/products/category/mens-shirts');

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var data = await networkHelper.fetchData();
      setState(() {
        response = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(Icons.location_on, color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('./assets/images/logo_upscaled.png',
                  height: MediaQuery.of(context).size.width * 0.1),
              const SizedBox(width: 8),
              const Text(
                "SwipeFit",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {},
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.pink),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : response != null
                        ? ImageSwiper(response: response!)
                        : const Center(child: Text('Failed to load products')),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        bottomNavigationBar: BottomNavbar(currIdx: selected));
  }
}
