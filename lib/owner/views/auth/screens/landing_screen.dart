

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/owner/models/owner_user_models.dart';

import '../owner_registration_screen.dart';
import 'main_owner_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '\landing-screen';
  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _ownersStream =
    FirebaseFirestore.instance.collection('owners');

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
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
              borderRadius: BorderRadius.circular(5),
              child:  Image.network(
                ownerUserModel.storeImage.toString(),
                width: 90,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Text(
              ownerUserModel.bussinessName.toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Text('Your application has been sent to admin\n Admin will get back to you soon',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
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
            child: Text('Signout'),
            ),
          ],
        ));
      },
    ));
    
  }
}