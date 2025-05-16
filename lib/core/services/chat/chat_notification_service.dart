import 'package:chat_flutter/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];
  List<ChatNotification> get items => [..._items];

  int get count => _items.length;

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  Future<void> init() async {
    // keep it this order
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    final isAuthorized = await _isAuthorized;
    if (!isAuthorized) return;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) => _messageHandler(message));
  }

  Future<void> _configureBackground() async {
    final isAuthorized = await _isAuthorized;
    if (!isAuthorized) return;

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => _messageHandler(message));
  }

  Future<void> _configureTerminated() async {
    final isAuthorized = await _isAuthorized;
    if (!isAuthorized) return;

    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      _messageHandler(message);
    }
  }

  void _messageHandler(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      add(ChatNotification(
        title: notification.title ?? 'No title',
        body: notification.body ?? 'No body',
      ));
    }
  }
}