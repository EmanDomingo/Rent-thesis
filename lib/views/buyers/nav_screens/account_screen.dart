import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_app/views/buyers/auth/login_screen.dart';
import 'package:rental_app/views/buyers/inner_screens/edit_profile.dart';
import 'package:rental_app/views/buyers/inner_screens/reservation_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/category_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/store_screen.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    // return _auth.currentUser == null
    //     ? Scaffold(
    //         appBar: AppBar(
    //           elevation: 2,
    //           backgroundColor: const Color.fromARGB(255, 60, 128, 184),
    //           title: Text(
    //             'Profile',
    //             style: TextStyle(
    //               color: const Color.fromARGB(255, 60, 128, 184),
    //               fontFamily: 'JosefinSans',
    //               fontWeight: FontWeight.w600,
    //               fontSize: 20,
    //             ),
    //           ),
    //           actions: [
    //             Padding(
    //               padding: const EdgeInsets.all(14.0),
    //               child: Icon(Icons.star),
    //             ),
    //           ],
    //         ),
    //         body: SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               Center(
    //                 child: CircleAvatar(
    //                   radius: 64,
    //                   backgroundColor: Colors.blue.shade300,
    //                   child: Icon(
    //                     Icons.person,
    //                     size: 80,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Text(
    //                   'Login Account To Access Profile',
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.pushReplacement(context,
    //                       MaterialPageRoute(builder: (context) {
    //                     return LoginScreen();
    //                   }));
    //                 },
    //                 child: Container(
    //                   height: 40,
    //                   width: MediaQuery.of(context).size.width - 200,
    //                   decoration: BoxDecoration(
    //                     color: Colors.blue.shade300,
    //                     borderRadius: BorderRadius.circular(5),
    //                     boxShadow: [],
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       'LOGIN ACCOUNT',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         letterSpacing: 2,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 18,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
        // :
        return FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'PROFILE',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 60, 128, 184),
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.blue.shade300,
                            backgroundImage: NetworkImage(data['profileImage']),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['fullName'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['email'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditProfileScreen(
                                userData: data,
                              );
                            }));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 200,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 60, 128, 184),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ]),
                            child: Center(
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CategoryScreen();
                            }));
                          },
                          leading: SvgPicture.asset(
                            'assets/icons/favorite.svg',
                            width: 20,
                          ),
                          title: Text('Categories'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return StoreScreen();
                            }));
                          },
                          leading: Icon(Icons.list),
                          title: Text('List Owners'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CustomerReservationScreen();
                            }));
                          },
                          leading: SvgPicture.asset(
                            'assets/icons/favorite.svg',
                            width: 20,
                          ),
                          title: Text('Approval'),
                        ),
                        ListTile(
                          onTap: () async {
                            await _auth.signOut().whenComplete(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            });
                          },
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          );
  }
}
