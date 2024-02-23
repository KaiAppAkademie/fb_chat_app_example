import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_chat_example/data/chat_repository.dart';
import 'package:fb_chat_example/domain/message_model.dart';

class FirebaseChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Stream<List<MessageModel>> get messageChannel => _firestore
      .collection("messages")
      .snapshots()
      .map((instance) => instance.docs
          .map((entry) => MessageModel.fromFirestore(entry))
          .toList());

  @override
  void resetAllMessages() {
    final CollectionReference<Map<String, dynamic>> messagesCollectionsRef =
        _firestore.collection('messages');
    messagesCollectionsRef.get().then((snapshot) {
      for (final doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  @override
  void sendMessage(MessageModel messageModel) {
    final CollectionReference<Map<String, dynamic>> messagesCollectionsRef =
        _firestore.collection('messages');
    messagesCollectionsRef.add({
      "messageSenderName": messageModel.messageSenderName,
      "message": messageModel.message,
      "timestamp": messageModel.timestamp
    });
  }



  @override
  void deleteMessage(MessageModel messageModel) {
    final CollectionReference<Map<String, dynamic>> messagesCollectionsRef =
        _firestore.collection('messages');
      messagesCollectionsRef.doc(messageModel.id).delete();
  }
}
