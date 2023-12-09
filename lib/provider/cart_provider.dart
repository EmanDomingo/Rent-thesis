
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/models/cart_attributes.dart';

class CartProvider with ChangeNotifier{
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItem{

    return _cartItems;
  }

  double get totalPrice {
    var total = 0.00;

    _cartItems.forEach((key, value) {
      total += value.price; //* value.quantity;
    });

    return total;
  }

  void addProductToCart(
    String productName,
    String productId,
    List imageUrl,
    // int quantity,
    // int productQuantity,
    double price,
    String ownerId,
    String productAddress,
    String productContnum,
    String productPersons,
    String productSubmeter,
    String productPets,
    String category,
    String productSize,
    Timestamp scheduleDate,
    ) {
      if(_cartItems.containsKey(productId)){
        _cartItems.update(productId,
        (exitingCart) => CartAttr(
          productName: exitingCart.productName,
          productId: exitingCart.productId,
          imageUrl: exitingCart.imageUrl,
          // quantity: exitingCart.quantity +1,
          // productQuantity: exitingCart.productQuantity,
          price: exitingCart.price,
          ownerId: exitingCart.ownerId,
          productSize: exitingCart.productSize,
          productAddress: exitingCart.productAddress,
          productContnum: exitingCart.productContnum,
          productPersons: exitingCart.productPersons,
          productSubmeter: exitingCart.productSubmeter,
          productPets: exitingCart.productPets,
          category: exitingCart.category,
          scheduleDate: exitingCart.scheduleDate,
          ));

        notifyListeners();
      } else {
        _cartItems.putIfAbsent(productId,
        () => CartAttr(
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          // quantity: quantity,
          // productQuantity:productQuantity,
          price: price,
          ownerId: ownerId,
          productSize: productSize,
          productAddress: productAddress,
          scheduleDate: scheduleDate,
          productContnum: productContnum,
          productPersons: productPersons,
          productSubmeter: productSubmeter,
          productPets: productPets,
          category: category,
          ));
        
        notifyListeners();
      }
    }

  // void increment(CartAttr cartAttr) {
  //   cartAttr.increase();

  //   notifyListeners();
  // }

  // void decrement(CartAttr cartAttr) {
  //   cartAttr.decrease();

  //   notifyListeners();
  // }

  removeItem(productId) {
    _cartItems.remove(productId);

    notifyListeners();
  }

  removeAllItem(){
    _cartItems.clear();

    notifyListeners();
  }
}