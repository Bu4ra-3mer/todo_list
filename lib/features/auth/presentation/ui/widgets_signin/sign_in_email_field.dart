import 'package:flutter/material.dart';

class SignInEmailField extends StatelessWidget {
  const SignInEmailField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) => value!.isEmpty ? 'Enter Your Email' : null,
    );
  }
}