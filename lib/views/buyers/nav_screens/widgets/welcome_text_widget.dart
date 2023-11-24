


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
          Text('TAGUIG CITY \n     Rent Application',
          style: TextStyle(
            fontFamily: 'JosefinSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 60, 128, 184),
          ),
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