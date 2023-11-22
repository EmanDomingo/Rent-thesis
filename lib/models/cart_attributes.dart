

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier{

  final String productName;
  final String productId;
  final List imageUrl;
  // int quantity;
  // int productQuantity;
  final double price;
  final String ownerId;
  final String productAddress;
  final String productContnum;
  final String productSubmeter;
  final String productPets;
  final String category;

  final String productSize;
  Timestamp scheduleDate;

  CartAttr(
  {required this.productName,
  required this.productId,
  required this.imageUrl,
  // required this.quantity,
  // required this.productQuantity,
  required this.price,
  required this.ownerId,
  required this.productSize,
  required this.scheduleDate,
  required this.productAddress,
  required this.productContnum,
  required this.productSubmeter,
  required this.productPets,
  required this.category,
  });

  // void increase() {
  //   quantity++;
  // }

  // void decrease() {
  //   quantity--;
  // }
}