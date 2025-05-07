import 'package:flutter/material.dart';

class NewMessageWidget extends StatelessWidget {
  const NewMessageWidget({
    super.key,
    // required this.NewMessage,
    // required this.onMessageTap,
  });

  // final List<Message> NewMessage;
  // final Function(Message) onMessageTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No NewMessage yet.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}