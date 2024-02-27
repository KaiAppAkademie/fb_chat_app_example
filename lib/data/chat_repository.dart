import 'package:fb_chat_example/domain/message.dart';

abstract class ChatRepository {
  Stream<List<Message>> get messageChannel;
  void deleteAllMessages();
  void sendMessage(Message message);
  void deleteMessage(Message message);
  void editMessage(Message message);
}
