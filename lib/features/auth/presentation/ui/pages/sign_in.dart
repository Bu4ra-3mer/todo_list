import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/routes/app_router.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signin/sign_in_button.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signin/sign_in_email_field.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signin/sign_in_password_field.dart';
import 'package:todo_list/features/auth/presentation/ui/widgets_signin/sign_in_user_name_field.dart';


@RoutePage()
class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: BlocConsumer<AuthCubitCubit, AuthCubitState>(
        listener: (context, state) {
          state.maybeWhen(
            signInSuccess: (user) {
              final authCubit = context.read<AuthCubitCubit>();
              authCubit.getCurrentUser();
              context.router.replaceAll([const StringItemRoute()]);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign In Success')),
              );
            },
            signInFailure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign in Failure')),
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
                  SizedBox(height: 10),
                  SignInEmailField(emailController: _emailController),
    
                  SizedBox(height: 10),
                  SignInPasswordField(
                    passwordController: _passwordController,
                  ),
                  SignInUserNameField(
                    userNameController: _userNameController,
                  ),
    
                  SizedBox(height: 20),
                  state.maybeWhen(
                    signInLoading: () => const CircularProgressIndicator(),
                    orElse:
                        () => SignInButton(
                          formKey: _formKey,
                          userNameController: _userNameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
