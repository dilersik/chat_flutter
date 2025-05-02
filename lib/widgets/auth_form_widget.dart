import 'dart:io';

import 'package:flutter/material.dart';

import '../core/models/auth_form_data.dart';
import 'image_picker_widget.dart';

class AuthFormWidget extends StatefulWidget {
  final void Function(AuthFormData formData) onSubmit;

  const AuthFormWidget({super.key, required this.onSubmit});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                _formData.isLogin ? 'Login' : 'Register',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              if (_formData.isSignup)
                ImagePickerWidget(onImagePicked: (file) => _handleImagePicked(file),),
              if (_formData.isSignup) const SizedBox(height: 10),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (value) => _formData.name = value,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              if (_formData.isSignup) const SizedBox(height: 10),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (value) => _formData.email = value,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (value) => _formData.password = value,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (_formData.isSignup && value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              if (_formData.isSignup) const SizedBox(height: 10),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('confirmPassword'),
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _formData.password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () => _submit(), child: Text(_formData.isLogin ? 'Login' : 'Register')),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => setState(() => _formData.toggleAuthMode()),
                child: Text(_formData.isLogin ? 'Create an account' : 'Already have an account?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleImagePicked(File? image) {
    _formData.image = image;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_formData.isSignup && _formData.image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please pick an image')));
      return;
    }

    _formKey.currentState?.save();

    widget.onSubmit(_formData);
  }
}
