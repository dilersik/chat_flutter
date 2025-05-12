import 'package:chat_flutter/core/services/chat/chat_notification_service.dart';
import 'package:chat_flutter/pages/notifications_page.dart';
import 'package:chat_flutter/widgets/messages_widget.dart';
import 'package:chat_flutter/widgets/new_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [Icon(Icons.exit_to_app, color: Colors.black87), SizedBox(width: 8), Text('Logout')],
                  ),
                ),
              ],
              onChanged: (value) => {if (value == 'logout') AuthService().logout()},
              icon: Icon(Icons.more_vert),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NotificationsPage())),
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                top: 2,
                right: 4,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    "${Provider.of<ChatNotificationService>(context).count}",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(child: Column(children: [Expanded(child: MessagesWidget()), NewMessageWidget()])),
    );
  }
}
