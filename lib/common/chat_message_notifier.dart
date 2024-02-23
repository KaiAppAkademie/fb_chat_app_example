import 'package:fb_chat_example/data/chat_repository.dart';
import 'package:fb_chat_example/data/firebase_chat_repository.dart';
import 'package:fb_chat_example/domain/message_model.dart';
import 'package:flutter/material.dart';

class MessageModelNotifier extends ChangeNotifier {
  final ChatRepository _chatRepository = FirebaseChatRepository();

  final List<MessageModel> _chatMessages = [];

  List<MessageModel> get chatMessages => _chatMessages;

  MessageModelNotifier() {
    _subscripeMessageChannel();
  }

  Future<void> _subscripeMessageChannel() async {
    try {
      _chatRepository.messageChannel.listen((messages) {
        _chatMessages.clear();
        _chatMessages.addAll(messages);
        _sortByTimeStamp();
        notifyListeners();
      });
    } catch (e) {
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  void _sortByTimeStamp() {
    _chatMessages.sort((messageOne, messageTwo) =>
        messageTwo.timestamp.compareTo(messageOne.timestamp));
  }

  Future<void> resetChat() async {
    _chatRepository.resetAllMessages();
  }

  Future<void> sendMessage(MessageModel messageModel) async {
    _chatRepository.sendMessage(messageModel);
  }
}
