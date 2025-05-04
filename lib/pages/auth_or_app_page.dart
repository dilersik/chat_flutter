import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service_mock.dart';
import 'package:chat_flutter/pages/chat_page.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';
import 'loading_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthServiceMock().onUserChanged,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          return snapshot.hasData ? const ChatPage() : const AuthPage();
        },
      ),
    );
  }
}
