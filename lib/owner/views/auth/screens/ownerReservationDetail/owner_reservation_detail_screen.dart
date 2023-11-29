


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rental_app/owner/views/auth/screens/edit_reservation_screen.dart';
import 'package:rental_app/utils/show_snackBar.dart';

class OwnerReservationDetailScreen extends StatefulWidget {
  final dynamic reservationData;

  const OwnerReservationDetailScreen({super.key, required this.reservationData});

  @override
  State<OwnerReservationDetailScreen> createState() => _OwnerReservationDetailScreenState();
}

class _OwnerReservationDetailScreenState extends State<OwnerReservationDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productAddressController = TextEditingController();
  final TextEditingController _productContnumController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.reservationData['productName'];
      _productAddressController.text = widget.reservationData['productAddress'];
      _productContnumController.text = widget.reservationData['productContnum'];
      _productPriceController.text = widget.reservationData['productPrice'].toString();
      _productDescriptionController.text = widget.reservationData['description'];
      _categoryNameController.text = widget.reservationData['category'];

    });
    super.initState();
  }

  double? productPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          widget.reservationData['productName'],
          style: TextStyle(
            color: Color.fromRGBO(12, 100, 56, 1),
          ),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                enabled: true,
                controller: _categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Category'
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name'
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _productAddressController,
                decoration: InputDecoration(
                  labelText: 'Address'
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _productContnumController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Contact Number'
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  productPrice = double.parse(value);
                },
                controller: _productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price'
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLength: 300,
                maxLines: 2,
                controller: _productDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description'
                ),
              ),
            ],
          ),
        ),
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () async {
            if (productPrice!=null) {
              await _firestore
            .collection('products')
            .doc(widget.reservationData['productId'])
            .update({
              'productName':_productNameController.text,
              'productAddress':_productAddressController.text,
              'productContnum':_productContnumController.text,
              'productPrice':productPrice,
              'description':_productDescriptionController.text,
              'category':_categoryNameController.text,
            }).whenComplete(() {
                    EasyLoading.dismiss();
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return EditReservationScreen();
                    }));
                  });
            } else {
              showSnack(context, 'Update Price');
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width -40,
            decoration: BoxDecoration(
              color: Colors.green.shade500,
              borderRadius: BorderRadius.circular(10),
            ),
        
            child: Center(
              child: Text('UPDATE RESERVATION',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
        ),
      ),
    );
  }
}