import 'package:chat_flutter/widgets/auth_form_widget.dart';
import 'package:flutter/material.dart';

import '../models/auth_form_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(child: SingleChildScrollView(child: AuthFormWidget(onSubmit: _handleSubmit))),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3)),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  void _handleSubmit(AuthFormData formData) {
    setState(() => _isLoading = true);

    setState(() => _isLoading = false);
  }
}
