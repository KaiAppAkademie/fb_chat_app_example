import 'dart:developer';

import 'package:fb_chat_example/common/chat_message_notifier.dart';
import 'package:fb_chat_example/domain/message.dart';
import 'package:fb_chat_example/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
    required this.model,
    required this.controller,
  });

  final Message model;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final chatNotifier = context.read<ChatMessageNotifier>();

    return SizedBox(
      height: 220,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 184, 138, 2),
                    size: 60,
                  ),
                  onTap: () {
                    log("Edit Button");
                    chatNotifier.changeEditingState(true);
                    controller.text = model.text;
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 40),
                CustomButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 196, 49, 16),
                    size: 60,
                  ),
                  onTap: () {
                    chatNotifier.deleteMessage(model);
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
