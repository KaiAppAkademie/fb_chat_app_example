import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_chat_example/common/chat_message_notifier.dart';
import 'package:fb_chat_example/domain/message_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<MessageModelNotifier>(context);
    TextEditingController controller = TextEditingController();
    String appUser = "Lukas";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 176, 242, 178),
        centerTitle: true,
        title: const Text("Basic Chat Application"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: chatProvider.chatMessages.length,
              itemBuilder: (context, index) {
                final chatMessage = chatProvider.chatMessages[index];
                return GestureDetector(
                  onLongPress: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return _buildBottomSheet();
                      },
                    );
                  },
                  child: BubbleSpecialThree(
                    text: chatMessage.message,
                    isSender:
                        chatMessage.messageSenderName == appUser ? true : false,
                    tail: false,
                    color: chatMessage.messageSenderName == appUser
                        ? const Color(0xFF1B97F3)
                        : const Color(0xFFE8E8EE),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            color: const Color.fromARGB(255, 197, 197, 197),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () =>
                        _sendMessage(chatProvider, appUser, controller.text),
                    child:
                        const Icon(Icons.send, size: 30, color: Colors.white)),
                border: const OutlineInputBorder(),
                labelText: 'Enter a Message',
              ),
            ),
          )
        ],
      ),
    );
  }

  void _sendMessage(MessageModelNotifier chatProvider, String appUser,
      String messageContent) {
    final message = MessageModel(
        id: "UNUSED",
        messageSenderName: appUser,
        message: messageContent,
        timestamp: Timestamp.now());
    chatProvider.sendMessage(message);
  }

  Widget _buildBottomSheet() {
    return const SizedBox(
      height: 200,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      )),
    );
  }
}
