import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipefit/Screens/cartpage_screen.dart';
import 'package:swipefit/Screens/homepage_screen.dart';
import 'package:swipefit/Screens/likepage_screen.dart';
import 'package:swipefit/Screens/profile_screen.dart';

class BottomNavbar extends StatefulWidget {
  int currIdx;
  BottomNavbar({super.key, required this.currIdx});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      onTap: (index) {
        setState(() {
          widget.currIdx = index;

          switch (widget.currIdx) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomepageScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LikedPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
              break;
            default:
              break;
          }
        });
      },
      currentIndex: widget.currIdx,
      items: [
        BottomBarItem(
          icon: const FaIcon(
            FontAwesomeIcons.house,
            size: 20,
          ),
          title: const Text('Home'),
          backgroundColor: const Color(0xFFFF84B8),
        ),
        BottomBarItem(
          icon: const FaIcon(
            FontAwesomeIcons.cartShopping,
            size: 20,
          ),
          title: const Text('Cart'),
          backgroundColor: const Color(0xFFFF84B8),
        ),
        BottomBarItem(
          icon: const FaIcon(
            FontAwesomeIcons.heart,
            size: 20,
          ),
          title: const Text('Like'),
          backgroundColor: const Color(0xFFFF84B8),
        ),
        BottomBarItem(
          icon: const Icon(
            Icons.person,
            size: 25,
          ),
          title: const Text('Profile'),
          backgroundColor: const Color(0xFFFF84B8),
        ),
      ],
      option: BubbleBarOptions(
        barStyle: BubbleBarStyle.vertical,
        bubbleFillStyle: BubbleFillStyle.fill,
        opacity: 0.3,
      ),
    );
  }
}
