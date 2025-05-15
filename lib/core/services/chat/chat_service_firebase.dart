import 'dart:async';

import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() => Stream.empty();

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = await store
        .collection('chat')
        // .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
        .add({
          'text': text,
          'createdAt': DateTime.now().toIso8601String(),
          'userId': user.id,
          'userName': user.name,
          'userImageURL': user.imageUrl,
        });
    final doc = await docRef.get();
    final data = doc.data();
    if (data == null) {
      throw Exception('Error saving message');
    }
    return ChatMessage(
      id: doc.id,
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt']),
      userId: data['userId'],
      userName: data['userName'],
      userImageUrl: data['userImageURL'],
    );
  }

  ChatMessage fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
      SnapshotOptions? options,
  ) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Error converting message');
    }
    return ChatMessage(
      id: doc.id,
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt']),
      userId: data['userId'],
      userName: data['userName'],
      userImageUrl: data['userImageURL'],
    );
  }

  Map<String, dynamic> toFirestore(ChatMessage message) {
    return {
      'text': message.text,
      'createdAt': message.createdAt.toIso8601String(),
      'userId': message.userId,
      'userName': message.userName,
      'userImageURL': message.userImageUrl,
    };
  }

}
