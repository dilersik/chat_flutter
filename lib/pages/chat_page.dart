import 'package:chat_flutter/widgets/messages_widget.dart';
import 'package:chat_flutter/widgets/new_message_widget.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [Icon(Icons.exit_to_app, color: Colors.black87), SizedBox(width: 8), Text('Logout')],
                ),
              ),
            ],
            onChanged: (value) => {if (value == 'logout') AuthService().logout()},
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(child: Column(children: [Expanded(child: MessagesWidget()), NewMessageWidget()])),
    );
  }
}
