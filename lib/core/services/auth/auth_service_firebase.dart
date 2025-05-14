import 'dart:async';
import 'dart:io';

import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServiceFirebase implements AuthService {

  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      if (user == null) {
        _currentUser = null;
        controller.add(null);
      } else {
        _currentUser = ChatUser(
          id: user.uid,
          name: user.displayName ?? user.email?.split('@')[0] ?? '',
          email: user.email ?? '',
          imageUrl: user.photoURL ?? '',
        );
        controller.add(_currentUser);
      }
    }
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get onUserChanged => _userStream;

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async => FirebaseAuth.instance.signOut();

  @override
  Future<void> signUp(String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;

    if (user != null) {
      final imageUrl = await uploadImage(image, '${user.uid}.jpg');

      await user.updateDisplayName(name);
      await user.updatePhotoURL(imageUrl);

      await _saveChatUser(ChatUser(id: user.uid, name: name, email: email, imageUrl: imageUrl));
    }
  }

  Future<String?> uploadImage(File? image, String imageName) async {
    if (image == null) return null;
    final storageRef = FirebaseStorage.instance.ref().child('user_images').child(imageName);
    await storageRef.putFile(image).whenComplete(() {});
    return await storageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final userRef = store.collection('users').doc(user.id);
    return await userRef.set({'name': user.name, 'email': user.email, 'imageUrl': user.imageUrl});
  }
}
