

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/chat/chat_page.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen({super.key});

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 2,
        //backgroundColor: Color.fromARGB(255, 167, 215, 255),
        title: Text('LIST OWNERS',
        style: TextStyle(
          color: const Color.fromARGB(255, 60, 128, 184),
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 189, 225, 255),Color.fromARGB(255, 255, 255, 255),], // Add your gradient colors here
          ),
        ),
        child: _buildUserList()),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('owners').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }

        return ListView(
          children: snapshot.data!.docs
          .map<Widget>((doc) => _buildUserListItem(doc))
          .toList(),
        );
      }
    );
  }
  
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text (data['bussinessName'],
              style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(53, 61, 104, 1),
                          ),
                        ),
                        subtitle: Text(data['countryValue']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['storeImage']),
                              
                            ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: ((context) => ChatPage(
                    receiverUserEmail: data['bussinessName'],
                    receiverUserID: data['ownerId'],
                  ))
                  )
                );
              },
            ),
            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Divider(
                                thickness: 1,
                                color: Color.fromARGB(255, 214, 214, 214),
                              ),
                            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
