

import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/nav_screens/account_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/cart_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/category_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/chat_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/confirm_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    // StoreScreen(),
    ChatMessageScreen(),
    // SearchScreen(),
    CartScreen(),
    ConfirmScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        //backgroundColor: Color.fromRGBO(255, 251, 230, 1),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Color.fromRGBO(55, 99, 150, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Color.fromRGBO(55, 99, 150, 1),
        selectedItemColor: Color.fromRGBO(39, 71, 107, 1),
        items: [
        BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list_alt_rounded),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.format_list_numbered_rounded),
      label: 'List Owners',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.house_siding_rounded),
      label: 'Reservation',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.check_circle_outline_rounded),
      label: 'Approval',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: 'Account',
    ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 149, 207, 255),Color.fromARGB(255, 255, 255, 255),], // Add your gradient colors here
          ),
        ),
        child: _pages[_pageIndex],
      ),
      
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: const Color.fromARGB(255, 60, 128, 184),
      //   icon: Icon(Icons.chat,
      //   color: Colors.white,),
      //   label: Text("Chat",
      //   style: TextStyle(
      //     color: Colors.white
      //   ),),
      //   tooltip: 'Connect to Assistant',
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return Chatbot();
      //       }));
      //   },),
    );
  }
}