import 'dart:async';
import 'dart:io';

import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFirebase implements AuthService {

  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controllerUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      if (user == null) {
        _currentUser = null;
        controller.add(null);
      } else {
        _currentUser = _toChatUser(user);
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
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async => FirebaseAuth.instance.signOut();

  @override
  Future<void> signUp(String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;

    if (user != null) {
      user.updateDisplayName(name);
      // user.updatePhotoURL(image?.path);
    }
  }

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email?.split('@')[0] ?? '',
      email: user.email ?? '',
      imageUrl: user.photoURL ?? '',
    );
  }

}
