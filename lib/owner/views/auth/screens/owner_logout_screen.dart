

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/auth/login_screen.dart';

class OwnerLogoutScreen extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 189, 255, 214),Color.fromARGB(255, 255, 255, 255),], // Add your gradient colors here
          ),
        ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation', style: TextStyle(fontSize: 24)),
                      content: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Are you sure you want to login customer\'s account?'),
                      ),
                      backgroundColor: Colors.grey[200],
                      actions: [
                        TextButton(
                          child: Text('Cancel', style: TextStyle(color: Colors.blue)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text('Yes', style: TextStyle(color: Colors.green)),
                          onPressed: () async {
                            await _auth.signOut().whenComplete(() {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                  }));
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Login Customer\'s Account',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 60, 184, 126)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _auth.signOut();
              },
              child: Text('Signout',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 245, 90, 79)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal:20, vertical: 10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}