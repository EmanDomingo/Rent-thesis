

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/provider/cart_provider.dart';
import 'package:rental_app/views/buyers/inner_screens/checkout_screen.dart';
import 'package:rental_app/views/buyers/main_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('RESERVATION',
        style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(CupertinoIcons.delete,
            color: Colors.white,
            ),
          ),
        ],
      ),
      body: _cartProvider.getCartItem.isNotEmpty?
      ListView.builder(
        shrinkWrap: true,
        itemCount: _cartProvider.getCartItem.length,
        itemBuilder: (context, index) {
          final cartData = _cartProvider.getCartItem.values.toList()[index];
          return Card(
            child: SizedBox(
            height: 170,
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(cartData.imageUrl[0]),
                ),

                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartData.productName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(53, 61, 104, 1),
                          ),
                        ),
                        Text(
                        cartData.productContnum,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(53, 61, 104, 1),
                          ),
                        ),
                        Text(
                        'P' + '' + cartData.price.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            color: Colors.yellow.shade900,
                          ),
                        ),

                        IconButton(
                              onPressed: () {
                                _cartProvider.removeItem(
                                  cartData.productId,
                                );
                              },
                              icon: Icon(
                              CupertinoIcons.delete,
                              color: Colors.grey.shade600,
                              ),
                            ),
                  
                        // OutlinedButton(
                        //   onPressed: null,
                        //   child: Text(
                        //     cartData.productSize,
                        //   ),
                        // ),
                  
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 40,
                        //       width: 115,
                              // decoration: BoxDecoration(
                              //   color: Colors.blue.shade300,
                              // ),
                  
                              // child: Row (
                              //   children: [
                              //     IconButton(
                              //       onPressed: cartData.quantity == 1
                              //       ? null
                              //       : () {
                              //         _cartProvider.decrement(cartData);
                              //       },
                              //     icon: Icon(CupertinoIcons.minus,
                              //     color: Colors.white,
                              //       ),
                              //     ),
                  
                              //   Text(
                              //     cartData.quantity.toString(),
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       ),
                              //     ),
                  
                              //     IconButton(
                              //       onPressed: cartData.productQuantity == cartData.quantity
                              //       ? null
                              //       :() {
                              //         _cartProvider.increment(cartData);
                              //       },
                              //     icon: Icon(CupertinoIcons.plus,
                              //     color: Colors.white,
                              //     ))
                              //   ],
                              // ),
                            // ),

                        //     IconButton(
                        //       onPressed: () {
                        //         _cartProvider.removeItem(
                        //           cartData.productId,
                        //         );
                        //       },
                        //       icon: Icon(
                        //       CupertinoIcons.delete,
                        //       color: Colors.grey.shade600,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            ),
          );
        }):
        
      Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text (
              'Your Reservation is Empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),

            SizedBox(height: 20,),
            InkWell(
              onTap: ()  {
                Navigator.push
                (context, MaterialPageRoute(builder: (context) {
                  return MainScreen();
                }));
            },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width -40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                    ),
                  ]
                ),
                child: Center (
                  child: Text('CONTINUE RENTING',
                  style:  TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.totalPrice == 0.00
          ? null
          : () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CheckoutScreen();
          }
          )
          );
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color:  _cartProvider.totalPrice == 0.00
              ? Colors.grey
              : Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                    ),
                  ]
            ),
            child: Center(
              child: Text(
            "Php." + " " + _cartProvider.totalPrice.toStringAsFixed(2) + " " + 'CHECKOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}