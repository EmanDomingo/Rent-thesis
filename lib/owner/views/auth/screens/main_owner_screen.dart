

import 'package:flutter/material.dart';
import 'package:rental_app/owner/views/auth/screens/chat_owner.dart';
import 'package:rental_app/owner/views/auth/screens/earnings_screen.dart';
import 'package:rental_app/owner/views/auth/screens/edit_reservation_screen.dart';
import 'package:rental_app/owner/views/auth/screens/owner_logout_screen.dart';
import 'package:rental_app/owner/views/auth/screens/owner_reservation_screen.dart';
import 'package:rental_app/owner/views/auth/screens/upload_screen.dart';

class MainOwnerScreen extends StatefulWidget {
  const MainOwnerScreen({super.key});

  @override
  State<MainOwnerScreen> createState() => _MainOwnerScreenState();
}

class _MainOwnerScreenState extends State<MainOwnerScreen> {
  int  _pageIndex = 0;

  List<Widget> _pages = [
    EarningsScreen(),
    UploadScreen(),
    ChatOwnerScreen(),
    EditReservationScreen(),
    OwnerReservationScreen(),
    OwnerLogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromRGBO(55, 150, 110, 1),
        selectedItemColor: Color.fromRGBO(12, 100, 56, 1),
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
        BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline_rounded), label: 'Approval'),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
      ],),

      body: _pages[_pageIndex],
    );
  }
}