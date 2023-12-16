
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/owner/controllers/owner_register_controller.dart';
import 'package:rental_app/views/buyers/chat/chat_page.dart';
import 'package:rental_app/views/buyers/chat/chat_service.dart';
import 'package:rental_app/views/buyers/chatbot/chatbot.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen({super.key});

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String decryptPogi(String text) {
  final authController = OwnerController();
  final decodedText = authController.decrypt(text);
  return decodedText;
}

  int newMessageCount = 0; // Track the number of new messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIST OWNERS',
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
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 205, 233, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: _buildUserList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 60, 128, 184),
        icon: Icon(
          Icons.question_answer_outlined,
          color: Colors.white,
        ),
        label: Text(
          "FAQ's",
          style: TextStyle(color: Colors.white),
        ),
        tooltip: 'Connect to Assistant',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Chatbot();
          }));
        },
      ),
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
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data =
        document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
<<<<<<< HEAD
      return FutureBuilder<int>(
        future: ChatService().getUnreadMessageCount(
          _auth.currentUser!.uid,
          data['ownerId'],
=======
      return SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                data['timestamp'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(53, 61, 104, 1),
                ),
              ),
              subtitle: Text(
                data['countryValue'],
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data['storeImage']),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ChatPage(
                              receiverUserEmail: data['bussinessName'],
                              receiverUserID: data['ownerId'],
                            ))));
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
>>>>>>> 277708e37325938b905382c77bee9f73cb7bdc28
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
                  title: Text(
                    decryptPogi(data['bussinessName']),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(53, 61, 104, 1),
                    ),
                  ),
                  subtitle: Text(decryptPogi(data['countryValue'])),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(decryptPogi(data['storeImage'])),
                  ),
                  trailing: unreadMessageCount > 0
                      ? CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
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
                      data['ownerId'],
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ChatPage(
                          receiverUserEmail: data['bussinessName'],
                          receiverUserID: data['ownerId'],
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