import 'dart:async';

import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';

class ChatServiceMock implements ChatService {
  static final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Hello, how are you?',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'User 1',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'I am fine, thank you!',
      createdAt: DateTime.now(),
      userId: '2',
      userName: 'User 2',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'What about you?',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'User 1',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _messagesStreamController;
  static final _messagesStream = Stream<List<ChatMessage>>.multi((controller) {
    _messagesStreamController = controller;
    _messagesStreamController?.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() => _messagesStream;

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final chat = ChatMessage(
      id: DateTime.timestamp().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
    _messages.add(chat);
    _messagesStreamController?.add(_messages.reversed.toList());
    return chat;
  }


}