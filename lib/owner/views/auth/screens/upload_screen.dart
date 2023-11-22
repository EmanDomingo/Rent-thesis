

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/owner/views/auth/screens/main_owner_screen.dart';
import 'package:rental_app/owner/views/auth/screens/upload_tap_screens/attributes_tab_screens.dart';
import 'package:rental_app/owner/views/auth/screens/upload_tap_screens/general_screen.dart';
import 'package:rental_app/owner/views/auth/screens/upload_tap_screens/images_tab_screen.dart';
import 'package:rental_app/provider/product_provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
    Provider.of<ProductProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 60, 128, 184),
            elevation: 2,
            bottom: TabBar(tabs: [
              Tab(child: Text('Details',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 3,
              ),),
              ),
              //Tab(child: Text('Shipping'),),
              Tab(child: Text('Attributes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 3,
              ),),
              ),
              Tab(child: Text('Images',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 3,
              ),),
              ),
            ]),
          ),
      
          body: TabBarView(children: [
            GeneralScreen(),
            AttributesTabScreen(),
            ImagesTabScreen(),
          ],),
      
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: Colors.blue.shade300,
              ),
              onPressed: () async {
                EasyLoading.show(status: 'Please Wait...');
                if(_formKey.currentState!.validate()){
                  final productId = Uuid().v4();
                  await _firestore.collection('products').doc(productId).set({
                    'productId':productId,
                    'productName': _productProvider.productData['productName'],
                    'productAddress': _productProvider.productData['productAddress'],
                    'productPrice': _productProvider.productData['productPrice'],
                    'productContnum': _productProvider.productData['productContnum'],
                    'productSubmeter': _productProvider.productData['productSubmeter'],
                    'productPets': _productProvider.productData['productPets'],
                    //'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'imageUrl': _productProvider.productData['imageUrlList'],
                    'scheduleDate': _productProvider.productData['scheduleDate'],
                    //'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                    'ownerId': FirebaseAuth.instance.currentUser!.uid,
                    'approved': false,
                  }).whenComplete(() {
                    _productProvider.clearData();
                    _formKey.currentState!.reset();
                    EasyLoading.dismiss();
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return MainOwnerScreen();
                    }));
                  });
                }
              },
              child: Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}