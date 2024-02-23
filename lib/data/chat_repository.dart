import 'package:fb_chat_example/domain/message_model.dart';

abstract class ChatRepository {
  Stream<List<MessageModel>> get messageChannel;
  void resetAllMessages();
  void sendMessage(MessageModel messageModel);
  void deleteMessage(MessageModel messageModel);
}
