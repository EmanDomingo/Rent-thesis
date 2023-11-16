

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/nav_screens/account_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/cart_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/category_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/chat_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/confirm_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/home_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/search_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/store_screen.dart';

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
    StoreScreen(),
    ChatMessageScreen(),
    SearchScreen(),
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
          icon: Icon(CupertinoIcons.home),
          label: 'HOME',
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.circle_grid_3x3),
          label: 'CATEGORIES',
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.list_bullet),
          label: 'LIST OWNERS',
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble),
          label: 'CHAT',
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'SEARCH',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: 'RESERVATION',
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart),
          label: 'APPROVAL',
          ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'ACCOUNT',
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 144, 199, 245), // Start color
              Colors.white,   // End color
            ],
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