

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/inner_screens/all_products_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance.collection('categories').snapshots();

    return Scaffold(
      appBar: AppBar(
        //elevation: 2,
        //backgroundColor: Color.fromARGB(255, 167, 215, 255),
        title: Text('CATEGORIES',
        style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 189, 225, 255),Color.fromARGB(255, 255, 255, 255),], // Add your gradient colors here
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
        
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade300,
              ),
            );
          }
        
          return SingleChildScrollView(
            child: Container(
              height: 5000,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final categoryData = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                            return AllProductsScreen(categoryData: categoryData,);
                          }));
                      },
                      leading: Image.network(categoryData['image']),
                      title:  Text(
                        categoryData['categoryName'],
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(53, 61, 104, 1),
                        ),),
                    ),
                  );
              }),
            ),
          );
        },
            ),
      ),
    );
  }
}