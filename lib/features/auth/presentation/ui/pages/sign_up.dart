import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/routes/app_router.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signup/sign_up_action_button.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signup/sign_up_email_field.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signup/sign_up_password_field.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signup/sign_up_user_name_field.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signup/switch_to_sign_in_button.dart';
@RoutePage()
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocConsumer<AuthCubitCubit, AuthCubitState>(
        listener: (context, state) {
          state.maybeWhen(
            signUpSuccess: (user) {
               final authCubit = context.read<AuthCubitCubit>();
              authCubit.getCurrentUser();
              context.router.replaceAll([const StringItemRoute()]);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign Up Success')),
              );
            },
            signUpFailure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SignUpEmailField(emailController: _emailController),
                  const SizedBox(height: 10),
                  SignUpPasswordField(passwordController: _passwordController),
                  const SizedBox(height: 10),
                  SignUpUserNameField(userNameController: _userNameController),
                  const SizedBox(height: 20),
                  state.maybeWhen(
                    signUpLoading: () => const CircularProgressIndicator(),
                    orElse: () => SignUpActionButton(
                      formKey: _formKey,
                      userNameController: _userNameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SwitchToSignInButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}