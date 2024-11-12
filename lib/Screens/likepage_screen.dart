import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipefit/components/bottom_navbar.dart';
import 'package:swipefit/providers/like_provider.dart';
import 'package:lottie/lottie.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  bool isLiked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Liked',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              // Change the heart icon based on whether likedItems is empty or not
              Provider.of<LikeProvider>(context).likedItems.isEmpty
                  ? Icons.favorite_border
                  : Icons.favorite,
              color: Colors.pink,
            ),
            onPressed: () {
              Provider.of<LikeProvider>(context, listen: false).clearList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of liked items
            Expanded(
              child: Consumer<LikeProvider>(
                builder: (context, likeProvider, child) {
                  if (likeProvider.likedItems.isEmpty) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/lottie/not-found.json'),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text('You didn\'t like anything :(')
                          ]),
                    );
                  }
                  return ListView.builder(
                    itemCount: likeProvider.likedItems.length,
                    itemBuilder: (context, index) {
                      final item = likeProvider.likedItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Stack(
                          children: [
                            // Display the liked item
                            item,

                            // Heart icon in the top-left corner
                            Positioned(
                                top: 8,
                                left: 8,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        likeProvider.removeItem(item);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ))),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(currIdx: 2),
    );
  }
}
