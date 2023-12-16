import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  bool messageRead; // Added boolean property

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message,
    required this.messageRead, // Added boolean parameter
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'messageRead': messageRead, // Include the boolean property
    };
  }

  // Create a factory constructor to create a Message object from a Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      receiverId: map['receiverId'],
      timestamp: map['timestamp'],
      message: map['message'],
      messageRead: map['messageRead'] ?? false, // Use the value from the map or default to false
    );
  }
}