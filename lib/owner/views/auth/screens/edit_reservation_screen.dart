

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
            title: Text(
              'MANAGE RESERVATION',
              style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
            ),
          

            bottom: TabBar(tabs: [
              Tab(child: Text('Published',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 60, 128, 184),
              ),),
              ),
              //Tab(child: Text('Shipping'),),
              Tab(child: Text('Unpublished',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 60, 128, 184),
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