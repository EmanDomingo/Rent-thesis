


import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/nav_screens/search_screen.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 20, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
                        'assets/image/rentop0.png', // Replace with your image path
                        height: 90, // Adjust the height as needed
                        width: 90, // Adjust the width as needed
                      ),
          InkWell(
            onTap: ()  {
                Navigator.push
                (context, MaterialPageRoute(builder: (context) {
                  return SearchScreen();
                }));
            },
            child: Container(
              child: Icon(Icons.search,
              color: const Color.fromARGB(255, 60, 128, 184),
              size: 43,
              ),
              width: 50,
            ),
          )
        ],
      ),
    );
  }
}