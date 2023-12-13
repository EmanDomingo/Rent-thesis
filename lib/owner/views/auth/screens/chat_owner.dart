

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/chat/chat_page.dart';

class ChatOwnerScreen extends StatefulWidget {
  const ChatOwnerScreen({super.key});

  @override
  State<ChatOwnerScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatOwnerScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 2,
        //backgroundColor: Color.fromARGB(255, 167, 215, 255),
        title: Text('CHAT',
        style: TextStyle(
          color: Color.fromRGBO(12, 100, 56, 1),
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
            colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 235, 255, 243),], // Add your gradient colors here
          ),
        ),
        child: _buildUserList()),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('buyers').snapshots(),
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
              title: Text (data['fullName'],
              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(53, 61, 104, 1),
                                ),
                              ),
                              subtitle: Text(data['email']),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['profileImage']),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: ((context) => ChatPage(
                    receiverUserEmail: data['fullName'],
                    receiverUserID: data['buyerId'],
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
