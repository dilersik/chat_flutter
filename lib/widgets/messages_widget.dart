import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';
import 'package:chat_flutter/widgets/message_bubble_widget.dart';
import 'package:flutter/material.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({
    super.key,
    // required this.messages,
    // required this.onMessageTap,
  });

  // final List<Message> messages;
  // final Function(Message) onMessageTap;

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final messages = snapshot.data ?? [];
        if (!snapshot.hasData || messages.isEmpty) {
          return Center(child: Text('No messages yet.', style: Theme.of(context).textTheme.bodyLarge));
        }

        return ListView.builder(
          itemCount: messages.length,
          reverse: true,
          itemBuilder: (ctx, index) {
            final message = messages[index];
            return MessageBubbleWidget(
              key: ValueKey(message.id),
              message: message,
              isMe: currentUser?.id == message.userId,
            );
          },
        );
      },
    );
  }
}
