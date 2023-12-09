
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/owner/views/auth/owner_auth_screen.dart';
import 'package:rental_app/views/buyers/auth/login_screen.dart';
import 'package:rental_app/views/buyers/inner_screens/edit_profile.dart';
import 'package:rental_app/views/buyers/nav_screens/category_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/chat_screen.dart';
import 'package:rental_app/views/buyers/nav_screens/confirm_screen.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
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
                    body: Container(
                      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 205, 233, 255),
            Color.fromARGB(255, 255, 255, 255),], // Add your gradient colors here
          ),
        ),
                      child: SingleChildScrollView(
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
                              leading: Icon(Icons.list_alt_rounded),
                              title: Text('Categories',
                              style: TextStyle(
                                color: Color.fromRGBO(53, 61, 104, 1),
                              ),),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChatMessageScreen();
                                }));
                              },
                              leading: Icon(Icons.format_list_numbered_rounded),
                              title: Text('List Owners',
                              style: TextStyle(
                                color: Color.fromRGBO(53, 61, 104, 1),
                              ),),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ConfirmScreen();
                                }));
                              },
                              leading: Icon(Icons.check_circle_outline_outlined),
                              title: Text('Approval',
                              style: TextStyle(
                                color: Color.fromRGBO(53, 61, 104, 1),
                              ),),
                            ),
                            ListTile(
                              onTap: () async {
                                final confirmLogout = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirmation'),
                                      content: Text('Are you sure you want to login owner\'s account?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: Text('Cancel', style: TextStyle(color: Colors.blue)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () => Navigator.pop(context, true),
                                          child: Text('Yes', style: TextStyle(color: Colors.green)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                        
                                if (confirmLogout) {
                                  await _auth.signOut().whenComplete(() {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return OwnerAuthScreen();
                                      }));
                                  });
                                }
                              },
                            leading: Icon(Icons.person),
                            title: Text('Login Owner\'s Account',
                            style: TextStyle(
                                color: Color.fromRGBO(53, 61, 104, 1),
                              ),),
                          ),
                            ListTile(
                              onTap: () async {
                                await _auth.signOut().whenComplete(() {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return LoginScreen();
                                      }));
                                });
                              },
                              leading: Icon(Icons.logout),
                              title: Text('Logout',
                              style: TextStyle(
                                color: Color.fromRGBO(53, 61, 104, 1),
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                
              }
              return Center(child: CircularProgressIndicator());
            },
          );
  }
}
