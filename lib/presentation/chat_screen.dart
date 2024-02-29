import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_chat_example/common/auth_notifier.dart';
import 'package:fb_chat_example/common/chat_message_notifier.dart';
import 'package:fb_chat_example/common/constants.dart';
import 'package:fb_chat_example/domain/message.dart';
import 'package:fb_chat_example/presentation/bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatNotifier = Provider.of<ChatMessageNotifier>(context);
    final authNotifier = Provider.of<AuthNotifier>(context);

    TextEditingController messageTextController = TextEditingController();

    final String currentUserName = authNotifier.currentUser!.email!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 176, 242, 178),
        centerTitle: true,
        title: Text(authNotifier.currentUser?.email ?? '???'),
        actions: [
          IconButton(
            onPressed: () {
              authNotifier.logoutUser();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: chatNotifier.chatMessages.length,
                itemBuilder: (context, index) {
                  final chatMessage = chatNotifier.chatMessages[index];
                  final messageSenderName = chatMessage.messageSenderName;

                  return GestureDetector(
                    onLongPress: () {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return BottomSheetContent(
                            model: chatMessage,
                            controller: messageTextController,
                          );
                        },
                      );
                    },
                    child: BubbleSpecialThree(
                      text: chatMessage.text,
                      isSender: messageSenderName == currentUserName,
                      tail: false,
                      color: messageSenderName == currentUserName
                          ? bubbleDefaultColor
                          : colorForUser(messageSenderName),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Container(
              color: const Color.fromARGB(255, 197, 197, 197),
              child: TextField(
                controller: messageTextController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (!chatNotifier.isEditing) {
                        final message = _createMessage(
                          currentUserName,
                          messageTextController.text,
                        );
                        chatNotifier.sendMessage(message);
                      } else {
                        //TODO: Edit Message
                        chatNotifier.changeEditingState(false);
                      }
                    },
                    child: const Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Enter a Message',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Message _createMessage(
    String appUser,
    String messageContent,
  ) {
    final message = Message(
        id: "UNUSED",
        messageSenderName: appUser,
        text: messageContent,
        timestamp: Timestamp.now());
    return message;
  }
}
