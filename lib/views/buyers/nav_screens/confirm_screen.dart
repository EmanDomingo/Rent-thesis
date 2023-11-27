

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmScreen extends StatelessWidget {
  
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
    .collection('orders')
    .where('buyerId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('APPROVAL',
        style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),

        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(Icons.approval_rounded,
            color: Colors.white,
            ),
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 189, 225, 255),Color.fromARGB(255, 255, 255, 255)], // Add your gradient colors here
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
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
        
              return Column(
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
                      : Text('Pending',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 244, 124, 54)),),
                        
                      trailing: Text('PHP.' + ' ' +
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
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                      ),
                    ),
        
                    subtitle: Text('View Reservation Details',),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 40, // Adjust the radius to your desired size
                          child: Image.network(
                            document['productImage'][0],
                            fit: BoxFit.cover, // You can use BoxFit to control how the image is fitted within the circle
                          ),
                        ),
        
                        title: Text(document['productName']),
        
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(('Desired room or bed no.'),
                                style: TextStyle(
                                  fontSize: 15,
                                ),),
        
                                Text(document['productSize'],
                                ),
                              ],
                            ),
        
                            document['accepted'] == true
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Schedule Reservation Date'),
                                Text(formatedDate(
                              document['scheduleDate'].toDate())),
                              ],
                            )
                            : Text(''),
        
                            ListTile(
                              title: Text(
                                'Customer Details:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
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
              );
            }).toList(),
          );
        },
            ),
      )
    );
  }
}