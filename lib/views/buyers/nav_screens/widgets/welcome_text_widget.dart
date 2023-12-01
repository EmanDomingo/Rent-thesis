


import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/nav_screens/search_screen.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
                        'assets/image/rent1.png', // Replace with your image path
                        height: 110, // Adjust the height as needed
                        width: 110, // Adjust the width as needed
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
              size: 50,
              ),
              width: 50,
            ),
          )
        ],
      ),
    );
  }
}