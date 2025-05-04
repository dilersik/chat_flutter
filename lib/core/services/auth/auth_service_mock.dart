import 'dart:async';
import 'dart:io';

import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';

class AuthServiceMock implements AuthService {
  static final _defaultUser = ChatUser(
    id: '1',
    name: 'Default User',
    email: 'user@email.com',
    imageUrl: 'assets/images/avatar.png',
  );
  static final Map<String, ChatUser> _users = {_defaultUser.email: _defaultUser};
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controllerUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controllerUser = controller;
    _updateUser(_defaultUser);
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get onUserChanged => _userStream;

  @override
  Future<void> login(String email, String password) async {
    if (!_users.containsKey(email)) {
      throw Exception('User not found');
    }

    final user = _users[email];
    if (user == null) {
      throw Exception('User not found');
    }

    // Simulate a password check
    if (password != '123') {
      throw Exception('Invalid password');
    }

    _updateUser(user);
  }

  @override
  Future<void> logout() async => _updateUser(null);

  @override
  Future<void> signUp(String name, String email, String password, File? image) async {
    if (_users.containsKey(email)) {
      throw Exception('User already exists');
    }

    final newUser = ChatUser(id: email, name: name, email: email, imageUrl: image?.path ?? 'assets/images/avatar.png');

    _users[email] = newUser;
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controllerUser?.add(user);
  }
}
