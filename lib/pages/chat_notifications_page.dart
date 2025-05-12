import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/chat/chat_notification_service.dart';

class ChatNotificationsPage extends StatelessWidget {
  const ChatNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: service.count,
        itemBuilder: (context, index) {
          final notification = items[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.body),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => service.remove(index),
            ),
          );
        },
      ),
    );
  }
}