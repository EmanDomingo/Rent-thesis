

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rental_app/owner/views/auth/screens/ownerReservationDetail/owner_reservation_detail_screen.dart';

class PublishedTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ownerProductStream = FirebaseFirestore.instance
    .collection('products')
    .where('ownerId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .where('approved',isEqualTo: true)
    .snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
      stream: _ownerProductStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue.shade300,
            ),
          );
        }

        if(snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No Published Reservation',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
          );
        }

        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              
              final ownerProductData = snapshot.data!.docs[index];
              return Slidable(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                          return OwnerReservationDetailScreen(
                            reservationData: ownerProductData,);
                        }));
                  },
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8,),
                      Container(
                        height: 80,
                        width: 80,
                        child: Image.network(ownerProductData['imageUrl'][0]
                        ),
                      ),
                SizedBox(width: 15,),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '' + '' + ownerProductData['productName'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                
                          Text(
                          '' + '' + ownerProductData['productContnum'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade300,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                              ),
                ),
  // Specify a key if the Slidable is dismissible.
  key: const ValueKey(0),

  // The start action pane is the one at the left or the top side.
  startActionPane: ActionPane(
    // A motion is a widget used to control how the pane animates.
    motion: ScrollMotion(),

    // A pane can dismiss the Slidable.

    // All actions are defined in the children parameter.
    children:  [
      // A SlidableAction can have an icon and/or a label.
      SlidableAction(
        flex: 2,
        onPressed: (context) async {
          await _firestore
          .collection('products')
          .doc(ownerProductData['productId'])
          .update({
            'approved':false,
          });
        },
        backgroundColor: Color(0xFF21B7CA),
        foregroundColor: Colors.white,
        icon: Icons.approval_rounded,
        label: 'Unpublish',
      ),
      SlidableAction(
        flex: 2,
        onPressed: (context) async {
          await _firestore
          .collection('products')
          .doc(ownerProductData['productId'])
          .delete();
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Delete',
      ),
    ],
  ));


            }),
        ),
        );
      },
    ),
    );
  }
}