import 'package:flutter/material.dart';

class SignInPasswordField extends StatelessWidget {
  const SignInPasswordField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (value) => value!.isEmpty ? 'Enter Your Password' : null,
    );
  }
}
