import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                Padding(
                  padding: EdgeInsets.only(
                    left: isMe ? 0 : 10,
                    right: isMe ? 10 : 0,
                    top: 0,
                    bottom: 10,
                  ),
                  child: Text(
                    "${message.userName} at ${_formatDateTime(message.createdAt.toLocal())}",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ],
        ),
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
    if (imageUrl == null || imageUrl.isEmpty) {
      return Image.asset("assets/images/avatar.png", width: 40, height: 40);
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

  String _formatDateTime(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) {
      // Same day: show only time
      return DateFormat('hh:mm a').format(createdAt); // e.g., 02:45 PM
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      // Less than a week ago: show weekday
      return DateFormat('EEEE').format(createdAt); // e.g., Monday
    } else {
      // Older: show date
      return DateFormat('dd/MM/yyyy').format(createdAt); // e.g., 08/05/2025
    }
  }
}
