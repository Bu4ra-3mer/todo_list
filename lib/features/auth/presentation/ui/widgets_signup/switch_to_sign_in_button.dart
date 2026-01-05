


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/routes/app_router.dart';

class SwitchToSignInButton extends StatelessWidget {
  const SwitchToSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pushRoute( SignInRoute());
      },
      child: const Text("Already have an account? Sign In"),
    );
  }
}

