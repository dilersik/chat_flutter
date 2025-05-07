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
    return Center(
      child: Text(
        'No messages yet.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}