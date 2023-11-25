

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/provider/product_provider.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  String formateDate(date){
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
    Provider.of<ProductProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              DropdownButtonFormField(
                hint: Text('Select category'),
                items: _categoryList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _productProvider.getFormData(category: value);
                });
              }),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter full name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter full name',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter rent address';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productAddress: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter rent address',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter contact number';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productContnum: value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter contact number',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter rent price per month';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productPrice: double.parse(value));
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter rent price per month',
                ),
              ),
              // SizedBox(height: 30,),
              // TextFormField(
              //   validator: (value) {
              //     if(value!.isEmpty) {
              //       return 'Enter Rental Quantity';
              //     } else {
              //       return null;
              //     }
              //   },
              //   onChanged: (value) {
              //     _productProvider.getFormData(quantity: int.parse(value));
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'Enter Rental Quantity',
              //   ),
              // ),
              SizedBox(
                height: 30,
                ),
              Row(children: [
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(5000)
                    ).then((value) {
                      setState(() {
                        _productProvider.getFormData(scheduleDate: value);
                      });
                    });
                  },
                child: Text('Click reservation due date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),),

                if(_productProvider.productData['scheduleDate']!=null)
                
                Text(formateDate(
                  _productProvider.productData['scheduleDate'],),
                ),
              ],),
              SizedBox(
                height: 30,
                ),
          ],
          ),
        ),
      ),
    );
  }
}