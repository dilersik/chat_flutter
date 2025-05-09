import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({super.key, required this.message, required this.isMe});

  final ChatMessage message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMe ? 12 : 0),
                      topRight: Radius.circular(isMe ? 0 : 12),
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: isMe ? 0 : 52,
                    right: isMe ? 52 : 0,
                  ),
                  child: Text(message.text, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                ),
                Text(
                  "${message.userName} at ", // ${message.createdAt.toLocal()}
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        if (message.userImageUrl != null)
          Positioned(
            top: 0,
            left: isMe ? null : 10,
            right: isMe ? 10 : null,
            child: _showUserImage(message.userImageUrl),
          ),
      ],
    );
  }

  Widget _showUserImage(String? imageUrl) {
    if (imageUrl == null) {
      return const SizedBox.shrink();
    }
    ImageProvider? provider;
    if (imageUrl.startsWith('http')) {
      provider = NetworkImage(imageUrl);
    } else {
      provider = AssetImage(imageUrl);
    }

    return CircleAvatar(
      backgroundImage: provider,
      radius: 20,
    );
  }
}
