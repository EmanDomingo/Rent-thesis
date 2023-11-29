

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('owners');
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
    .collection('orders')
    .where('ownerId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(data['storeImage']),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hi!' + ' ' + ' ' + data['bussinessName'],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(12, 100, 56, 1),
                    ),),
                  )
                ],
              ),
            ),

            body: Container(
              decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 189, 255, 214),Color.fromARGB(255, 255, 255, 255),], // Add your gradient colors here
          ),
        ),
              child: StreamBuilder<QuerySnapshot>(
                    stream: _ordersStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
              
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
              
                      double totalReservation = 0.0;
                      for(var orderItem in snapshot.data!.docs) {
                        totalReservation += orderItem ['productPrice'];
                      }
                      return Center (
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                                ),
                              ],
                        ),
              
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('TOTAL EARNINGS',
                              style: TextStyle(
                                color: Color.fromRGBO(12, 100, 56, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ),
              
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                              'PHP.' + ' ' +totalReservation.toStringAsFixed(2),
                              style: TextStyle(
                                color: Color.fromRGBO(12, 100, 56, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
              
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                                ),
                              ],
                        ),
              
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('TOTAL RESERVATION',
                              style: TextStyle(
                                color: Color.fromRGBO(12, 100, 56, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ),
              
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                snapshot.data!.docs.length.toString(),
                              style: TextStyle(
                                color: Color.fromRGBO(12, 100, 56, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
              
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //       return WithdrawalScreen();
                      //     }));
                      //   },
                      //   child: Container(
                      //     height: 40,
                      //     width: MediaQuery.of(context).size.width - 40,
                      //     decoration: BoxDecoration(
                      //       color: Colors.blue.shade300,
                      //       borderRadius: BorderRadius.circular(10),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey.shade600,
                      //           spreadRadius: 1,
                      //           blurRadius: 2,
                      //           offset: const Offset(0, 3),
                      //           ),
                      //         ],
                      //     ),
              
                      //     child: Center(
                      //       child: Text(
                      //         'Withdraw',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold,
                      //           letterSpacing: 5,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
                        },
                      ),
            ),
      );
    }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade300,
          )
        );
      },
    );
  }
}