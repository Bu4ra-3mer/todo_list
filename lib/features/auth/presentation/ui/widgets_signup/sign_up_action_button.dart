import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';


class SignUpActionButton extends StatelessWidget {
  const SignUpActionButton({
    super.key,
    required GlobalKey<FormState> formKey,
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
    return BlocConsumer<AuthCubitCubit, AuthCubitState>(
      listener: (context, state) {
        state.maybeWhen(
          signUpSuccess: (user) {
            Navigator.pushReplacementNamed(context, '/todoList');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Sign Up Success')));
          },
          signUpFailure: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign Up Failure: $message')),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          signUpLoading: () => const CircularProgressIndicator(),
          orElse:
              () => ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubitCubit>().signUp(
                      userName: _userNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  }
                },
                child: const Text('Sign Up'),
              ),
        );
      },
    );
  }
}