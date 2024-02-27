import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_chat_example/data/chat_repository.dart';
import 'package:fb_chat_example/domain/message.dart';

class FirebaseChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Message>> get messageChannel =>
      _firestore.collection("messages").snapshots().map(
            (instance) => instance.docs
                .map((entry) => Message.fromFirestore(entry))
                .toList(),
          );

  @override
  void deleteAllMessages() {
    final CollectionReference<Map<String, dynamic>> messagesCollectionsRef =
        _firestore.collection('messages');
    messagesCollectionsRef.get().then((snapshot) {
      for (final doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  @override
  void sendMessage(Message message) {
    final CollectionReference<Map<String, dynamic>> messagesCollectionRef =
        _firestore.collection('messages');
    messagesCollectionRef.add({
      "messageSenderName": message.messageSenderName,
      "text": message.text,
      "timestamp": message.timestamp
    });
  }

  @override
  void deleteMessage(Message message) {
    final CollectionReference<Map<String, dynamic>> messagesCollectionRef =
        _firestore.collection('messages');
    messagesCollectionRef.doc(message.id).delete();
  }

  @override
  void editMessage(Message message) {
    final CollectionReference<Map<String, dynamic>> messagesCollectionRef =
        _firestore.collection('messages');
    messagesCollectionRef.doc(message.id).update({'message': message.text});
  }
}
