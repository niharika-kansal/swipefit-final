import 'package:flutter/material.dart';
import 'package:swipefit/components/quantity_updater.dart';

void main() {
  runApp(ProductPageApp());
}

class ProductPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        
        title: Text(
          "",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
           
          IconButton(
            icon: Icon(Icons.camera_alt, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
          child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                
                      './assets/images/image1.jpg', 
                      // Replace with your image URL
                height: MediaQuery.of(context).size.width * 0.6,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Boucle Mini Dress-Ivory",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "-80%",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "\$205",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star_border, color: Colors.orange),
                SizedBox(width: 8),
                Icon(Icons.favorite_border),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Size",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: ["S", "M", "L", "XL"]
                  .map(
                    (size) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(size),
                        selected: false, // Replace with a state variable if needed
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16),
            Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Elegant and timeless, the Boucle Mini Dress in Ivory is the perfect blend of sophistication and comfort. Featuring a flattering off-shoulder neckline and a soft pleated skirt, this dress is designed to create a chic, feminine silhouette. Made from ...",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text("Read more"),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Quantity:",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 8),
                 QuantityUpdater()
              ],
            ),
         
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Buy now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),)
      
    );
  }
}
