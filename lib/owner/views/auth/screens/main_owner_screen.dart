

import 'package:flutter/cupertino.dart';
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
        backgroundColor: Color.fromRGBO(55, 99, 150, 1),
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromRGBO(12, 25, 100, 1),
        items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'UPLOAD'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'CHAT'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'EDIT'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.house), label: 'RESERVATION'),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'LOGOUT'),
      ],),

      body: _pages[_pageIndex],
    );
  }
}