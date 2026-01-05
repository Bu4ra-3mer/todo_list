

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/routes/app_router.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';

class TasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'My Tasks',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.home_rounded, color: Colors.black87),
          onPressed: () => context.router.push(const LandingRoute()),
        ),
        BlocBuilder<AuthCubitCubit, AuthCubitState>(
          builder: (context, state) {
            final isGuest =
                context.read<AuthCubitCubit>().isAnonymousUser;
            return IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: isGuest ? Colors.grey : Colors.redAccent,
              ),
              tooltip: isGuest ? 'Not available for Guest' : 'Sign Out',
              onPressed: isGuest
                  ? null
                  : () => context.read<AuthCubitCubit>().signOut(),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
