import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/productDetail/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchedValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('approved', isEqualTo: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 128, 184),
        elevation: 2,
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              _searchedValue = value;
            });
          },
          decoration: InputDecoration(
              labelText: 'Search',
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ),
      ),
      body: _searchedValue == ''
          ? Center(
              child: Text(
                'Search For Reservation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                final searchedData = snapshot.data!.docs.where((element) {
                  return element['productAddress']
                      .toLowerCase()
                      .contains(_searchedValue.toLowerCase());
                });

                return SingleChildScrollView(
                  child: Column(
                    children: searchedData.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetailScreen(
                              productData: e,
                            );
                          }));
                        },
                        child: Card(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.network(e['imageUrl'][0]),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '' + " " + e['productAddress'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(53, 61, 104, 1),
                                    ),
                                  ),
                                  Text(
                                    'Php.' +
                                        " " +
                                        e['productPrice'].toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      color: Color.fromRGBO(242, 133, 0, 1),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
