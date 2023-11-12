

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/productDetail/product_detail_screen.dart';

class HomeproductWidget extends StatelessWidget {
  final String categoryName;

  const HomeproductWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
    .collection('products')
    .where('category', isEqualTo: categoryName)
    .where('approved', isEqualTo: true)
    .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return Container(
          height: 410,
          child: GridView.builder(
            itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20,
              childAspectRatio: 200/300),
          // child: ListView.separated(
          //   scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
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
                      SizedBox(
                        height: 10,
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
                            fontSize: 18,
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
          },
          //separatorBuilder: (context, _)=>SizedBox(width: 15,),
          //itemCount: snapshot.data!.docs.length
          ),
        );
      },
    );
  }
}