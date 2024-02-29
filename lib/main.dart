import 'package:fb_chat_example/chat_app.dart';
import 'package:fb_chat_example/common/auth_notifier.dart';
import 'package:fb_chat_example/common/chat_message_notifier.dart';
import 'package:fb_chat_example/data/firebase_auth_repository.dart';
import 'package:fb_chat_example/data/firebase_chat_repository.dart';
import 'package:fb_chat_example/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepository = FirebaseAuthRepository();
  final chatRepository = FirebaseChatRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(
            authRepository: authRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatMessageNotifier(
            chatRepository: chatRepository,
          ),
        ),
      ],
      child: const ChatApp(),
    ),
  );
}
