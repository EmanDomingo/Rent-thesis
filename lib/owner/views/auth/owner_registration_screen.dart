

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_app/utils/show_snackBar.dart';

import '../../controllers/owner_register_controller.dart';


class OwnerRegistrationScreen extends StatefulWidget {
  @override
  State<OwnerRegistrationScreen> createState() => _OwnerRegistrationScreenState();
}

class _OwnerRegistrationScreenState extends State<OwnerRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final OwnerController _ownerController = OwnerController();

  late String bussinessName;
  late String email;
  late String phoneNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _ownerController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _ownerController.pickStoreImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  _saveOwnerDetail() async {
    
    if(_formKey.currentState!.validate()) {
    await _ownerController.registerOwner(bussinessName, email, phoneNumber,
      countryValue, stateValue, cityValue,  _image) //_taxStatus!, taxNumber,
      .whenComplete(() {
        EasyLoading.dismiss();

        // setState(() {
        //   _formKey.currentState!.reset();

        //   _image = null;
        // });
      });
    } else {
      EasyLoading();
    }
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 189, 255, 200),], // Add your gradient colors here
          ),
        ),
      child: CustomScrollView(
        slivers: [ SliverAppBar(
          backgroundColor: Color.fromARGB(255, 232, 255, 236),
              pinned: true,
              stretchTriggerOffset: 150,
              expandedHeight: 200,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 232, 255, 236),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.shade700.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: _image != null
                                ? Image.memory(_image!)
                                : IconButton(
                                    onPressed: () {
                                      selectGalleryImage();
                                    },
                                    icon: Icon(CupertinoIcons.person_solid,
                                    size: 100,
                                    color: Colors.green.shade700,),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        bussinessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid name';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Enter Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid email address';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid phone number';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SelectState(
                              onCountryChanged: (value) {
                                setState(() {
                                  countryValue = value;
                                });
                              },
                              onStateChanged: (value) {
                                setState(() {
                                  stateValue = value;
                                });
                              },
                              onCityChanged: (value) {
                                setState(() {
                                  cityValue = value;
                                });
                              },
                              
                              ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (_image == null) {
                          showSnack(context, 'Please select an image');
                        } else {
                          _saveOwnerDetail();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
    ),
    );
  }
}