
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/di/injection.dart';
import 'package:todo_list/core/routes/app_router.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';
@RoutePage()
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubitCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Welcome")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushRoute(SignUpRoute());
                },
                child: const Text("Sign Up"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pushRoute(SignInRoute());
                },
                child: const Text('Sign In'),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
