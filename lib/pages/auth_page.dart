import 'package:chat_flutter/widgets/auth_form_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(child: SingleChildScrollView(child: AuthFormWidget())),
    );
  }
}
