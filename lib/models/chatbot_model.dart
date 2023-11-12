import 'package:flutter/material.dart';

class Product with ChangeNotifier{

  final String ownerId;
  final String productName;
  final String category;
  final double productPrice;
  //final List imageUrl;

  Product({
    required this.ownerId,
    required this.productName,
    required this.category,
    required this.productPrice,
    //required this.imageUrl,
  });

}