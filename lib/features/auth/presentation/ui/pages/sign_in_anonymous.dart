import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/routes/app_router.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';
@RoutePage()
class SignInAnonymousPage extends StatelessWidget {
  const SignInAnonymousPage({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In Anonymous')),
      body: BlocConsumer<AuthCubitCubit, AuthCubitState>(
        listener: (context, state) {
          state.maybeWhen(
            signInAnonymousSuccess: (user) {
              context.router.replace(const StringItemRoute());
              _showSnackBar(context, 'Sign In Anonymous Success!');
            },
    
            signInAnonymousFailure: (message, user) {
              _showSnackBar(context, 'Sign In Anonymous Failed!');
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Center(
            child: state.maybeWhen(
              signInAnonymousLoading: (user) => const CircularProgressIndicator(),
              orElse:
                  () => ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubitCubit>().signInAnonymous();
                    },
                    child: const Text("Login as Anonymous"),
                  ),
            ),
          );
        },
      ),
    );
  }
}
