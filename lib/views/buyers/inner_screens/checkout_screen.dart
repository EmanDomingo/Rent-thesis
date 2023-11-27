

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/provider/cart_provider.dart';
import 'package:rental_app/views/buyers/inner_screens/edit_profile.dart';
import 'package:rental_app/views/buyers/main_screen.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
      appBar: AppBar (
        title: Text('CONFIRM RESERVATION',
        style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 149, 207, 255),], // Add your gradient colors here
          ),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _cartProvider.getCartItem.length,
          itemBuilder: (context, index) {
            final cartData = _cartProvider.getCartItem.values.toList()[index];
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Card(
                child: SizedBox(
                height: 170,
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(cartData.imageUrl[0]),
                    ),
            
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.productName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(53, 61, 104, 1),
                                ),
                              ),
                              Text(
                              cartData.productContnum,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(53, 61, 104, 1),
                                ),
                              ),
                              
                              Text(
                              'PHP.' + ' ' + cartData.price.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                  color: Colors.yellow.shade900,
                                ),
                              ),
                                              
                              // OutlinedButton(
                              //   onPressed: null,
                              //   child: Text(
                              //     cartData.productSize,
                              //   ),
                              // ),
                                              
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                ),
              ),
            );
          }),
      ),

        bottomSheet: data['address'] == ''
        ? TextButton(
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return EditProfileScreen(
                  userData: data,);
              })).whenComplete(() {
                Navigator.pop(context);
              });
          }, child: Text('Enter Address'))
        : Padding(
          padding: const EdgeInsets.all(13.0),
          child: InkWell(
            onTap: () {
              EasyLoading.show(status: 'Placing Reservation');
              // we want to be able to place reservation
              _cartProvider.getCartItem.forEach((key, item) {
                final orderId = Uuid().v4();
                _firestore.collection('orders').doc(orderId).set({
                  'orderId':orderId,
                  'ownerId':item.ownerId,
                  'email':data['email'],
                  'phone':data['phoneNumber'],
                  'address':data['address'],
                  'buyerId':data['buyerId'],
                  'fullName':data['fullName'],
                  'userPhoto':data['profileImage'],
                  'productName':item.productName,
                  'productPrice':item.price,
                  'productId':item.productId,
                  'productImage':item.imageUrl,
                  // 'quantity':item.productQuantity,
                  'productSize':item.productSize,
                  'scheduleDate':item.scheduleDate,
                  'orderDate':DateTime.now(),
                  'accepted': false,
                  
                }).whenComplete(() {
                  setState(() {
                    _cartProvider.getCartItem.clear();
                  });

                  EasyLoading.dismiss();
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return MainScreen();
                  }));
                });
              });
            } ,
            child: Container(
              height: 50,
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
          
              child: Center(
                child: Text(
                  'PLACE RESERVATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ),
          ),
        ),
    );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade300,
          ),
        );
      },
    );
  }
}