import 'dart:async';

import 'package:chat_flutter/core/models/ChatMessage.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() => FirebaseFirestore.instance
      .collection('chat')
      .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final chat = ChatMessage(
      id: DateTime.now().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(chat);
    final doc = await docRef.get();
    return doc.data();
  }

  ChatMessage _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
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

  Map<String, dynamic> _toFirestore(ChatMessage chat, SetOptions? options) => {
    'text': chat.text,
    'createdAt': chat.createdAt.toIso8601String(),
    'userId': chat.userId,
    'userName': chat.userName,
    'userImageURL': chat.userImageUrl,
  };
}
