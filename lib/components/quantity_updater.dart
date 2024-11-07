import 'package:flutter/material.dart';

class QuantityUpdater extends StatefulWidget {
  const QuantityUpdater({super.key});

  @override
  State<QuantityUpdater> createState() => _QuantityUpdaterState();
}

class _QuantityUpdaterState extends State<QuantityUpdater> {

  int quantity = 1; 


  void _increaseQuantity(){
    setState(() {
      quantity = quantity + 1; 
    });
  }

  void _decreaseQuantity(){
    setState(() {
      if(quantity <=0){
        quantity = 0; 
      }
      else{
        quantity = quantity - 1; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
IconButton(onPressed: _decreaseQuantity, icon: Icon(Icons.remove)), 
        Text(quantity.toString()), 
        IconButton(onPressed: _increaseQuantity, icon: Icon(Icons.add))
      ],
    ); 
  }
}