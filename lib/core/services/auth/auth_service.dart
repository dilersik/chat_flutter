import 'dart:io';

import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service_firebase.dart';

abstract class AuthService {
  factory AuthService() => AuthServiceFirebase();

  ChatUser? get currentUser;
  Stream<ChatUser?> get onUserChanged;

  Future<void> signUp(String name, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();

}