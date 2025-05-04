import 'dart:io';

import 'package:chat_flutter/core/models/chat_user.dart';

import 'auth_service_mock.dart';

abstract class AuthService {
  factory AuthService() => AuthServiceMock();

  ChatUser? get currentUser;
  Stream<ChatUser?> get onUserChanged;

  Future<void> signUp(String name, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();

}