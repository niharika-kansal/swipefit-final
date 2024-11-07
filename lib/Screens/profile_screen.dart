import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipefit/Screens/initial_signup_screen.dart';
import 'package:swipefit/components/bottom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> signOut(BuildContext context) async {
   await FirebaseAuth.instance.signOut();
           Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return LoginSignUpScreen(); // Navigate to LoginSignUpScreen
      }),
    ); // Navigate to login screen after sign out
  }

  Future<void> deleteUser(BuildContext context) async {
   try{

          // Delete the user from Firebase Authentication
    await FirebaseAuth.instance.currentUser!.delete();

    // Navigate to LoginSignUpScreen after deletion
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return LoginSignUpScreen(); // Replace this with your login screen
      }),
    );

      } on FirebaseAuthException catch(e){
         if (e.code == 'requires-recent-login') {
      // If the user needs to re-authenticate, handle it here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please re-authenticate to delete your account.")),
      );
      // You can navigate to a re-authentication screen here if needed
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete account: ${e.message}")),
      );
    }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile image and user info
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, size: 60, color: Colors.grey[400]),
            ),
            SizedBox(height: 16),
            Text(
              'DroidDeveloper',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'User@DroidDeveloper',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),

            // Options section
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.inventory_2),
                    title: Text('Past Orders'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share With a Friend'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.report),
                    title: Text('Report an Error'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.contact_support),
                    title: Text('Contact Us'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Leave a Rating'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Log out button
            ElevatedButton(
              onPressed: () => signOut(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Log Out'),
            ),
            SizedBox(height: 16),

            // Delete account button
            ElevatedButton(
              onPressed: () => deleteUser(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(currIdx: 3),
    );
  }
}




    // ElevatedButton(onPressed: () async{
    //     
         
    // }, child: Text('sign out'), style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.red) ),), 




//  ElevatedButton(onPressed: () async{
//      
    // }, child: Text('delete account'))