import 'package:chat_flutter/core/services/auth/auth_service_mock.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Center(
        child: TextButton(
          onPressed: () => AuthServiceMock().logout(),
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
