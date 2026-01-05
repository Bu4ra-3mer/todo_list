import 'package:flutter/material.dart';

class SignUpPasswordField extends StatelessWidget {
  const SignUpPasswordField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator:(value) => value!.isEmpty ? 'Enter Your Password' : null,
    );
  }
}
