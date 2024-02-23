import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String messageSenderName;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.id,
      required this.messageSenderName,
      required this.message,
      required this.timestamp});

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final id = doc.id;
    final senderName = data["messageSenderName"];
    final message = data["message"];
    final timestamp = data["timestamp"];

    return MessageModel(
        id: id,
        messageSenderName: senderName,
        message: message,
        timestamp: timestamp);
  }
}
