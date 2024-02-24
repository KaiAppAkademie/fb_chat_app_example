import 'package:fb_chat_example/data/chat_repository.dart';
import 'package:fb_chat_example/data/firebase_chat_repository.dart';
import 'package:fb_chat_example/domain/message_model.dart';
import 'package:flutter/material.dart';

class MessageModelNotifier extends ChangeNotifier {
  final ChatRepository _chatRepository = FirebaseChatRepository();

  final List<MessageModel> _chatMessages = [];
  bool _isEditing = false;

  List<MessageModel> get chatMessages => _chatMessages;
  bool get isEditing => _isEditing;

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

  Future<void> deleteMessage(MessageModel messageModel) async {
    _chatRepository.deleteMessage(messageModel);
  }

  Future<void> updateChatMessage(MessageModel newMessageModel) async {
    _chatRepository.editMessage(newMessageModel);
  }

  void changeEditingState(bool newValue) {
    _isEditing = newValue;
    notifyListeners();
  }
}
