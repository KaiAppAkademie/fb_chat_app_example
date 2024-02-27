import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    required this.id,
    required this.messageSenderName,
    required this.text,
    required this.timestamp,
  });

  final String id;
  final String messageSenderName;
  final String text;
  final Timestamp timestamp;

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Message(
      id: doc.id,
      messageSenderName: data["messageSenderName"],
      text: data["text"],
      timestamp: data["timestamp"],
    );
  }
}
