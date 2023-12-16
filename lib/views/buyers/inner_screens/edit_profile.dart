

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rental_app/controllers/auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData;

  EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  
  String decryptPogi(String text) {
  final authController = AuthController();
  final decodedText = authController.decrypt(text);
  return decodedText;
}

  @override
  void initState() {
    setState(() {
      _fullNameController.text = decryptPogi(widget.userData['fullName']);
      _emailController.text = decryptPogi(widget.userData['email']);
      _phoneController.text = decryptPogi(widget.userData['phoneNumber']);
      _addressController.text = decryptPogi(widget.userData['address']);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDIT PROFILE',
        style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          )
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Enter full name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Enter phone',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Enter address',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () async {
            EasyLoading.show(status: 'UPDATING');
            await _firestore
            .collection('buyers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
              'fullName': _fullNameController.text,
              'email': _emailController.text,
              'phoneNumber': _phoneController.text,
              'address':_addressController.text,
          }).whenComplete(() {
            EasyLoading.dismiss();
            Navigator.pop(context);
          });
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width -40,
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                    ),
                  ]
            ),
              
            child: Center(
              child: Text(
                'UPDATE',
                style: TextStyle(
                    color:  Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
