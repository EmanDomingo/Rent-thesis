

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/productDetail/product_detail_screen.dart';

class StoreDetailScreen extends StatelessWidget {
  final dynamic storeData;

  const StoreDetailScreen({super.key, required this.storeData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
    .collection('products')
    .where('ownerId', isEqualTo: storeData['ownerId'])
    .where('approved', isEqualTo: storeData['approved'])
    .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          storeData['bussinessName'],
          style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),),
          
      ),

      body: StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue.shade300,
            ),
          );
        }

        if(snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No Product Uploaded',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
          );
        }

        return GridView.builder(
            itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20,
              childAspectRatio: 200/300),
              itemBuilder: (context, index){
                final productData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ProductDetailScreen(productData: productData,);
                  }));
                },

                child: Card(
                  elevation: 0.5,
                  color: Color.fromRGBO(244, 247, 255, 1),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productData['category'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(53, 61, 104, 1),
                            
                          ),),
                      ),
                        Container(
                          height: 150,
                          width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            productData['imageUrl'][0],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                                
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productData['productAddress'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(53, 61, 104, 1),
                            ),
                          ),
                        ),
                                
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                          'Php.' + " " + productData['productPrice'].toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Colors.yellow.shade900,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              }
        );
        
        },
      )
    );
  }
}