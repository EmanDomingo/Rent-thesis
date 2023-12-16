

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/owner/controllers/owner_register_controller.dart';
import 'package:rental_app/owner/models/owner_user_models.dart';

import '../owner_registration_screen.dart';
import 'main_owner_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '\landing-screen';

  String decryptPogi(String text) {
  final authController = OwnerController();
  final decodedText = authController.decrypt(text);
  return decodedText;
}
  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _ownersStream =
    FirebaseFirestore.instance.collection('owners');

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 189, 255, 200), Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 189, 255, 200),], // Add your gradient colors here
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
        stream: _ownersStream.doc(_auth.currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
      
          if (!snapshot.data!.exists) {
            return OwnerRegistrationScreen();
          }
          
          OwnerUserModel ownerUserModel = OwnerUserModel.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>);
      
            if(ownerUserModel.approved == true) {
              return MainOwnerScreen();
            }
      
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:  Image.network(decryptPogi(
                  ownerUserModel.storeImage.toString()),
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
      
              SizedBox(
                height: 15,
              ),
              Text(decryptPogi(
                ownerUserModel.bussinessName.toString()),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
      
              SizedBox(
                height: 10,
              ),
              Text('Your application has been sent to admin\n Admin will get back to you soon',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
      
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  await _auth.signOut();
                },
              child: Text('Signout',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              ),
            ],
          ));
        },
          ),
      ));
    
  }
}