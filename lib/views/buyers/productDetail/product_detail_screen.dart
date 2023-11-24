

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/provider/cart_provider.dart';
import 'package:rental_app/utils/show_snackBar.dart';
//import 'package:rental_app/utils/show_snackBar.dart';


class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date){
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),

        title: Text (
        widget.productData['productName'],
        style: TextStyle(
          color: Color.fromRGBO(53, 61, 104, 1),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: PhotoView(
                    imageProvider: NetworkImage(widget.productData['imageUrl'][_imageIndex]),),
                ),
      
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
      
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['imageUrl'].length,
                      itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          setState(() {
                            _imageIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue.shade900,
                              )
                            ),
                            height: 60,
                            width: 60,
                            child: Image.network(widget.productData['imageUrl'][index]),
                          ),
                        ),
                      );
                    }),
                  )),
              ],
            ),
      
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
              widget.productData['productAddress'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(53, 61, 104, 1),
              ),),
            ),
            SizedBox(height: 20),
            Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Electric and Water Submeter
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Color.fromRGBO(94, 96, 104, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  widget.productData['productName'],
                                  style: TextStyle(
                                    color: Color.fromRGBO(53, 61, 104, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                          SizedBox(width: 100), // Add spacing between columns
                          // Second Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Pets Allowed
                                Text(
                                  'Contact Number',
                                  style: TextStyle(
                                    color: Color.fromRGBO(94, 96, 104, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                widget.productData['productContnum'],
                                  style: TextStyle(
                                    color: Color.fromRGBO(53, 61, 104, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

            Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Electric and Water Submeter
                                Text(
                                  'Type',
                                  style: TextStyle(
                                    color: Color.fromRGBO(94, 96, 104, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  widget.productData['category'],
                                  style: TextStyle(
                                    color: Color.fromRGBO(53, 61, 104, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                          SizedBox(width: 100), // Add spacing between columns
                          // Second Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Pets Allowed
                                Text(
                                  'Monthly',
                                  style: TextStyle(
                                    color: Color.fromRGBO(94, 96, 104, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                'Php.' + ' ' + widget.productData['productPrice'].toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Color.fromRGBO(53, 61, 104, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Reservation Due Date',
                  style: TextStyle(
                    color: Color.fromRGBO(53, 61, 104, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),
            
                  Text(
                    formatedDate(widget.productData['scheduleDate'].toDate(),
                    ),
            
                    style: TextStyle(
                      color: Color.fromRGBO(242,133,0,1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ExpansionTile(
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Rental Description',
            //       style: TextStyle(
            //         color: Color.fromRGBO(53, 61, 104, 1),
            //         fontWeight: FontWeight.bold,
            //       ),),
                    
            //       Text('View More',
            //       style: TextStyle(
            //         color: Color.fromRGBO(53, 61, 104, 1),
            //         fontWeight: FontWeight.bold,
            //         ),),
            //       ],
            //     ),
              
                    
            //     children: [
            //       Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(
            //             widget.productData['description'],
            //             style: TextStyle(
            //               fontSize: 17,
            //               color: Color.fromRGBO(53, 61, 104, 1),
            //             ),
            //             textAlign: TextAlign.start,
            //           ),
            //         ),
            //     ],
            //   ),

              // Details ExpansionTile with Two Columns
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                          color: Color.fromRGBO(53, 61, 104, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'View',
                        style: TextStyle(
                          color: Color.fromRGBO(53, 61, 104, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    // Two-Column Layout
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Electric and Water Submeter
                                  Text(
                                    'Do Have Electric and Water Submeter?',
                                    style: TextStyle(
                                      color: Color.fromRGBO(94, 96, 104, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    widget.productData['productSubmeter'],
                                    style: TextStyle(
                                      color: Color.fromRGBO(53, 61, 104, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 25),
                                  // Other details
                                  Text(
                                    'Other details',
                                    style: TextStyle(
                                      color: Color.fromRGBO(53, 61, 104, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.productData['description'],
                                    style: TextStyle(
                                      color: Color.fromRGBO(53, 61, 104, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 25),
                                ],
                              ),
                            ),
                            SizedBox(width: 20), // Add spacing between columns
                            // Second Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Pets Allowed
                                  Text(
                                    'Pets Allowed?',
                                    style: TextStyle(
                                      color: Color.fromRGBO(94, 96, 104, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    widget.productData['productPets'],
                                    style: TextStyle(
                                      color: Color.fromRGBO(53, 61, 104, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ExpansionTile(title: Text('Available Size',),
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productData['sizeList'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: _selectedSize == widget.productData['sizeList'][index]
                        ? Colors.blue.shade300
                        : null,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _selectedSize = widget.productData['sizeList'][index];
                            });
                            print (_selectedSize);
                      
                          },
                          
                          child: Text(
                          widget.productData['sizeList'][index])),
                      ),
                    );
                }),
              ),
              SizedBox(height: 5),
            ],
            ),
            ],
        ),
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem.containsKey(widget.productData['productId'])
          ? null
          :
          () {
            if(_selectedSize==null) {
              return showSnack(context, 'Please Select A Size');
            } else {
              _cartProvider.addProductToCart(
              widget.productData['productName'],
              widget.productData['productId'],
              widget.productData['imageUrl'],
              //1,
              //widget.productData['quantity'],
              widget.productData['productPrice'],
              widget.productData['ownerId'],
              widget.productData['productAddress'],
              widget.productData['productContnum'],
              widget.productData['productSubmeter'],
              widget.productData['category'],
              widget.productData['productPets'],
              _selectedSize!,
              widget.productData['scheduleDate'],
              );

              return showSnack(context,
              'You Added ${widget.productData['productName']} To Your Reservation');
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _cartProvider.getCartItem.containsKey(widget.productData['productId'])
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
        
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(CupertinoIcons.house,
                  color: Colors.white,
                  size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:_cartProvider.getCartItem.containsKey(widget.productData['productId'])
                  ? Text(
                    'IN RESERVATION',
                  style: TextStyle(
                    color:  Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 3,
                    ),
                  )
                  : Text(
                    'ADD TO RESERVATION',
                  style: TextStyle(
                    color:  Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 3,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}