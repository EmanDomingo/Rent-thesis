

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class OwnerReservationScreen extends StatelessWidget {
  
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
    .collection('orders')
    .where('ownerId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots();

    return Scaffold(
      appBar: AppBar(

        title: Text('MY RESERVATION',
        style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
      stream: _ordersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue.shade300,),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {

            return Slidable(
              child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: document['accepted']==true
                    ? Icon(Icons.directions_walk)
                    : Icon(Icons.access_time)),

                    title: document['accepted'] == true
                    ? Text('Accepted',
                    style: TextStyle(
                      color: Colors.green.shade500),)
                    : Text('Not Accepted',
                    style: TextStyle(
                      color: Colors.red.shade500),),
                      
                    trailing: Text('Amount' + ' ' +
                    document['productPrice'].toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue
                    ),
                    ),

                    subtitle: Text(
                      formatedDate(document['orderDate'].toDate()),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                ),

                ExpansionTile(title:
                Text('Reservation Details',
                style: TextStyle(
                  color: Colors.blue.shade300,
                  fontSize: 15,
                    ),
                  ),

                  subtitle: Text('View Reservation Details'),
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Image.network(document['productImage'][0]),
                      ),

                      title: Text(document['productName']),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Text(('Quantity'),
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                              
                          //     ),

                          //     Text(document['quantity'].toString(),),
                          //   ],
                          // ),

                          document['accepted'] == true
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Schedule Reservation Date'),
                              Text(formatedDate(
                            document['scheduleDate'].toDate())),
                            ],
                          )
                          : Text(''),

                          ListTile(
                            title: Text(
                              'Buyer Details',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),

                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(document['fullName']),
                                Text(document['email']),
                                Text(document['address']),
                                Text(document['phone']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),

  startActionPane: ActionPane(
    motion: const ScrollMotion(),
    children: [
      SlidableAction(
        onPressed: (context) async {
          await _firestore
          .collection('orders')
          .doc(document['orderId'])
          .update({
            'accepted': true,
          });
        },
        backgroundColor:Color(0xFF21B7CA),
        foregroundColor: Colors.white,
        icon: Icons.approval_rounded,
        label: 'Accept',
      ),
      SlidableAction(
        onPressed: (context) async {
          await _firestore
          .collection('orders')
          .doc(document['orderId'])
          .update({
            'accepted': false,
          });
        },
        backgroundColor: Color.fromARGB(255, 236, 210, 61),
        foregroundColor: Colors.white,
        icon: Icons.access_time,
        label: 'Reject',
      ),
      SlidableAction(
        onPressed: (context) async {
          await _firestore
          .collection('orders')
          .doc(document['orderId'])
          .delete();
        },
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Delete',
      ),
    ],
  ));
            
            
          }).toList(),
        );
      },
    )
    );
  }
}