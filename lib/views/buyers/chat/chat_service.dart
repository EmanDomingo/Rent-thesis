import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rental_app/models/message.dart';

class ChatService extends ChangeNotifier {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {

    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
      messageRead: false, // Set the initial value for messageRead
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _fireStore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .orderBy('timestamp', descending: false)
    .snapshots();
  }

  // Update the messageRead status when a message is read
  Future<void> markMessageAsRead(String userId, String otherUserId) async {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    final QuerySnapshot messagesSnapshot = await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('receiverId', isEqualTo: userId)
        .where('messageRead', isEqualTo: false)
        .get();

    for (QueryDocumentSnapshot messageDoc in messagesSnapshot.docs) {
      await messageDoc.reference.update({'messageRead': true});
    }
  }

  Future<int> getUnreadMessageCount(String userId, String otherUserId) async {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    final QuerySnapshot unreadMessagesSnapshot = await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .where('receiverId', isEqualTo: userId)
        .where('messageRead', isEqualTo: false)
        .get();

    return unreadMessagesSnapshot.size;
  }
}