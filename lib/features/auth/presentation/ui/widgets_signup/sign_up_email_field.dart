import 'package:flutter/material.dart';

class SignUpEmailField extends StatelessWidget {
  const SignUpEmailField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: (value) => value!.isEmpty ? 'Enter your Email' : null,
    );
  }
}