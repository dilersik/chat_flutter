import 'package:chat_flutter/widgets/auth_form_widget.dart';
import 'package:flutter/material.dart';

import '../core/models/auth_form_data.dart';
import '../core/services/auth/auth_service.dart';

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

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        await AuthService().login(formData.email, formData.password);
      } else {
        await AuthService().signUp(formData.name, formData.email, formData.password, formData.image);
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
