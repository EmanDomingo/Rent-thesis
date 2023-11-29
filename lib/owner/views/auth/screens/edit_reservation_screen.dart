

import 'package:flutter/material.dart';
import 'package:rental_app/owner/views/auth/screens/edit_reservation_tabs/published_tab.dart';
import 'package:rental_app/owner/views/auth/screens/edit_reservation_tabs/unpublished_tab.dart';

class EditReservationScreen extends StatelessWidget {
  const EditReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 60, 184, 126),
            elevation: 2,
            bottom: TabBar(tabs: [
              Tab(child: Text('Published',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),),
              ),
              //Tab(child: Text('Shipping'),),
              Tab(child: Text('Unpublished',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),),
              ),
            ]),
          ),

          body: TabBarView(
              children: [
                PublishedTab(),
                UnpublishedTab(),
              ],
            ),
        ),
      )
    );
  }
}