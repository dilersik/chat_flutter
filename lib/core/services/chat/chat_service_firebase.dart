import 'dart:async';

import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatService {

  @override
  Stream<List<ChatMessage>> messagesStream() => Stream.empty();

  @override
  Future<void> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageURL': user.imageUrl,
    });
  }

}