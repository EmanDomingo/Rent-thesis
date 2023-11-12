

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
              DropdownButtonFormField(
                hint: Text('Select Category'),
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
                    return 'Enter Your Full Name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Your Full Name',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Rent Address';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productAddress: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Rent Address',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Your Contact Number';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productContnum: value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Your Contact Number',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Rent Price';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productPrice: double.parse(value));
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Rent Price',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Do Have Electric and Water Submeter?';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productSubmeter: value);;
                },
                decoration: InputDecoration(
                  labelText: 'Have Electric and Water Submeter?',
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Pets Allowed?';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productPets: value);;
                },
                decoration: InputDecoration(
                  labelText: 'Pets Allowed?',
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
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Other Description';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                maxLines: 4,
                maxLength: 300,
                decoration: InputDecoration(
                  labelText: 'Enter Other Description',
                  border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(10),
                  ),
                ),
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
                child: Text('Reservation Due Date'),),

                if(_productProvider.productData['scheduleDate']!=null)
                
                Text(formateDate(
                  _productProvider.productData['scheduleDate'],),
                ),
              ],),
          ],
          ),
        ),
      ),
    );
  }
}