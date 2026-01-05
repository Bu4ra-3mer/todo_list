import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/routes/app_router.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:todo_list/features/todo_list/presentation/cubit/cubit_cubit.dart';
@RoutePage()
class SignOutPage extends StatelessWidget {
 const SignOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Out')),
      body: BlocConsumer<AuthCubitCubit, AuthCubitState>(
        listener: (context, state) {
          state.maybeWhen(
            signOutSuccess: () {
              log(
                "Sign out success → navigating to StringItemRoute",
                name: "SignOutPage",
              );
              final stringCubit = context.read<StringItemCubit>();
              stringCubit.clearItems();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Signed out successfully, now you are a Guest"),
                ),
              );
              context.router.replace(const StringItemRoute());
            },
            signOutFailure: (message) {
              log("Sign out failed: $message", name: "SignOutPage");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Sign out failed: $message")),
              );
            },
            orElse: () {},
          );
        },

        builder: (context, state) {
          final authCubit = context.read<AuthCubitCubit>();

          final isLoading = state.maybeWhen(
            signOutLoading: () => true,
            orElse: () => false,
          );

          return Center(
            child:
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed:
                          authCubit.isAnonymousUser
                              ? null
                              : () async {
                                await authCubit.signOut();
                              },
                      child: const Text('Sign Out'),
                    ),
          );
        },
      ),
    );
  }
}
