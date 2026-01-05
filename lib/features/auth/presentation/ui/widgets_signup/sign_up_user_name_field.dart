import 'package:flutter/material.dart';

class SignUpUserNameField extends StatelessWidget {
  const SignUpUserNameField({
    super.key,
    required TextEditingController userNameController,
  }) : _userNameController = userNameController;

  final TextEditingController _userNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userNameController,
      decoration: const InputDecoration(labelText: 'UserName'),
      validator: (value) => value!.isEmpty ? 'Enter your UserName' : null,
    );
  }
}
