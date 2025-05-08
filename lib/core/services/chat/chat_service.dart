import 'dart:async';

import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:chat_flutter/core/models/chat_user.dart';

import 'chat_service_mock.dart';

abstract class ChatService {
  factory ChatService() => ChatServiceMock();

  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> save(String text, ChatUser user);
}
