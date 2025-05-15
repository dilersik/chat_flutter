import 'dart:async';

import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/chat/chat_service_firebase.dart';

abstract class ChatService {
  factory ChatService() => ChatServiceFirebase();

  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?> save(String text, ChatUser user);
}
