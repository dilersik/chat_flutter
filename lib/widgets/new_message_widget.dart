import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({super.key});

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  String _enteredMessage = '';
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value) => setState(() => _enteredMessage = value),
            decoration: InputDecoration(
              hintText: 'Type a message',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onSubmitted: (_) => _enteredMessage.trim().isEmpty ? null : _sendMessage(),
          ),
        ),
        IconButton(icon: Icon(Icons.send), onPressed: _enteredMessage.trim().isEmpty ? null : () => _sendMessage()),
      ],
    );
  }

  Future<void> _sendMessage() async {
    if (_enteredMessage.trim().isEmpty) {
      return;
    }
    final user = AuthService().currentUser;
    if (user == null) {
      return;
    }
    await ChatService().save(_enteredMessage, user);

    _messageController.clear();
    setState(() => _enteredMessage = '');
  }
}
