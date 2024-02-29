import 'package:fb_chat_example/common/auth_notifier.dart';
import 'package:fb_chat_example/presentation/chat_screen.dart';
import 'package:fb_chat_example/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authNotifier.isUserLoggedIn
          ? const ChatScreen()
          : const LoginScreen(),
    );
  }
}
