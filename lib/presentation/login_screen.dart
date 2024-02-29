import 'package:fb_chat_example/common/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController mailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    mailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ValueNotifier userCredential = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            // const SizedBox(height: 20.0),
            // SignInButton(
            //   Buttons.Google,
            //   mini: false,
            //   onPressed: () async {
            //     userCredential.value =
            //         await widget.repository.signInWithGoogle();

            //     if (userCredential.value != null) {
            //       print(userCredential.value.user!.email);
            //     }
            //   },
            // ),
            ElevatedButton(
              onPressed: () {
                String mail = mailController.text.trim();
                String password = passwordController.text.trim();

                authNotifier.loginUser(mail, password);
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
                onPressed: () {
                  String mail = mailController.text.trim();
                  String password = passwordController.text.trim();
                  authNotifier.signUp(mail, password);
                },
                child: const Text("SignUp")),
            ElevatedButton(
                onPressed: () {
                  String mail = mailController.text.trim();
                  authNotifier.resetPassword(mail);
                },
                child: const Text("Reset Password"))
          ],
        ),
      ),
    );
  }
}
