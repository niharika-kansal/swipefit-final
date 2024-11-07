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

 
 
class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {

  int selected = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.location_on, color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('./assets/images/logo_upscaled.png', height:  MediaQuery.of(context).size.width * 0.1 ), // Replace with your logo image
            SizedBox(width: 8),
            Text(
              "SwipeFit",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
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
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.pink),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ImageSwiper()
            ),
          ),
   SizedBox(height: 16),


        
     
        ],


      ),
      
      bottomNavigationBar: BottomNavbar(currIdx: selected)); 
  
  }
}





// ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Stack(
//                   alignment: Alignment.bottomLeft,
//                   children: [
//                     Image.asset(
//                       './assets/images/image1.jpg', // Replace with your image URL
//                       fit: BoxFit.fill,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(16),
//                       color: Colors.black.withOpacity(0.5),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Frosty winter blue jacket",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "\$255",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),