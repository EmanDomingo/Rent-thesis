

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OwnerLogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          _auth.signOut();
        },
        child: Text('Signout',
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 2,
        ),),
      ),
    );
  }
}