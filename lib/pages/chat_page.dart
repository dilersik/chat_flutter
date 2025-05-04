import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Center(
        child: TextButton(
          onPressed: () => AuthService().logout(),
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
