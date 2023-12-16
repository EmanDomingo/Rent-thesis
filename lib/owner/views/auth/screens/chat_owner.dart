
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/controllers/auth_controller.dart';
import 'package:rental_app/views/buyers/chat/chat_page.dart';
import 'package:rental_app/views/buyers/chat/chat_service.dart';

class ChatOwnerScreen extends StatefulWidget {
  const ChatOwnerScreen({super.key});


  @override
  State<ChatOwnerScreen> createState() => _ChatOwnerScreenState();
}

class _ChatOwnerScreenState extends State<ChatOwnerScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String decryptPogi(String text) {
  final authController = AuthController();
  final decodedText = authController.decrypt(text);
  return decodedText;
}
  int newMessageCount = 0; // Track the number of new messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHAT',
          style: TextStyle(
            color: const Color.fromRGBO(12, 100, 56, 1),
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
        child: _buildUserList(),
      ),
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
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data =
        document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return FutureBuilder<int>(
        future: ChatService().getUnreadMessageCount(
          _auth.currentUser!.uid,
          data['buyerId'],
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          int unreadMessageCount = snapshot.data ?? 0;

          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(decryptPogi(
                    data['fullName']),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(53, 61, 104, 1),
                    ),
                  ),
                  subtitle: Text(decryptPogi(data['email'])),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(decryptPogi(data['profileImage'])),
                  ),
                  trailing: unreadMessageCount > 0
                      ? CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15,
                          child: Text(
                            '$unreadMessageCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : null,
                  onTap: () async {
                    await ChatService().markMessageAsRead(
                      _auth.currentUser!.uid,
                      data['buyerId'],
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ChatPage(
                          receiverUserEmail: data['fullName'],
                          receiverUserID: data['buyerId'],
                        )),
                      ),
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
        },
      );
    } else {
      return Container();
    }
  }
}
