import 'package:fb_chat_example/data/chat_repository.dart';
import 'package:fb_chat_example/domain/message.dart';
import 'package:flutter/material.dart';

class ChatMessageNotifier extends ChangeNotifier {
  ChatMessageNotifier({required chatRepository})
      : _chatRepository = chatRepository {
    _subscribeMessageChannel();
  }

  final ChatRepository _chatRepository;

  final List<Message> _chatMessages = [];
  bool _isEditing = false;

  List<Message> get chatMessages => _chatMessages;
  bool get isEditing => _isEditing;

  Future<void> _subscribeMessageChannel() async {
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
    _chatRepository.deleteAllMessages();
  }

  Future<void> sendMessage(Message message) async {
    _chatRepository.sendMessage(message);
  }

  Future<void> deleteMessage(Message message) async {
    _chatRepository.deleteMessage(message);
  }

  Future<void> updateMessage(Message message) async {
    _chatRepository.editMessage(message);
  }

  // TODO: Implement :)
  void changeEditingState(bool newValue) {
    _isEditing = newValue;
    notifyListeners();
  }
}
