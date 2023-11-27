

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/productDetail/product_detail_screen.dart';

class MainProductsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
    .collection('products')
    .where('approved', isEqualTo: true)
    .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LinearProgressIndicator(
              color: Colors.blue.shade900,
            ),
          );
        }

        return Container(
          height: 410,
          child: GridView.builder(
            itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20,
              childAspectRatio: 220/300),
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
                            color: Color.fromRGBO(53, 61, 104, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                              color: Color.fromRGBO(53, 61, 104, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                                
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                          'PHP.' + " " + productData['productPrice'].toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Color.fromRGBO(242,133,0,1),
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }),
        );
      },
    );
  }
}

