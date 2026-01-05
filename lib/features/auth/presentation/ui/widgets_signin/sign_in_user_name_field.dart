import 'package:flutter/material.dart';

class SignInUserNameField extends StatelessWidget {
  const SignInUserNameField({
    super.key,
    required TextEditingController userNameController,
  }) : _userNameController = userNameController;

  final TextEditingController _userNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userNameController,
      decoration: InputDecoration(labelText: 'UserName'),
      validator: (value) => value!.isEmpty ? 'Enter your UserName' : null,
    );
  }
}
