import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
   
    required GlobalKey<FormState>formKey,
    required TextEditingController userNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : _formKey = formKey,
       _userNameController = userNameController,
       _emailController = emailController,
       _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _userNameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<AuthCubitCubit>().signIn(
            userName: _userNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          );
        }
      },
      child: const Text('Sign in'),
    );
  }
}
