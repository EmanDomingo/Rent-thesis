

import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/auth/login_screen.dart';
import 'package:rental_app/views/buyers/auth/register_screen.dart';

class LandingFirstScreen extends StatefulWidget {
  const LandingFirstScreen({super.key});

  @override
  State<LandingFirstScreen> createState() => _LandingFirstScreenState();
}

class _LandingFirstScreenState extends State<LandingFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 107, 174, 230),Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 107, 174, 230),], // Add your gradient colors here
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/rentop3.png', // Replace with your image path
                   height: 230, // Adjust the height as needed
                   width: 230, // Adjust the width as needed
                ),
                Text(
                      'WELCOME TO',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'RENT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 55,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: 'UP',
                        style: TextStyle(
                          fontSize: 55,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60,),
                InkWell(
                  onTap: ()  {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreen();
                    }));
                },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width -225,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
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
                    child: Center (
                      child: Text('LOGIN',
                      style:  TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: ()  {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return BuyerRegisterScreen();
                  }));
                },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width -150,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
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
                    child: Center (
                      child: Text('REGISTER',
                      style:  TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100,),
              ],
            ),
            
          ),
          ],
        ),
      ),
    );
  }
}