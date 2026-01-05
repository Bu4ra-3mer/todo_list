import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/features/auth/presentation/ui/pages/landing_page.dart';
import 'package:todo_list/features/auth/presentation/ui/pages/sign_in.dart';
import 'package:todo_list/features/auth/presentation/ui/pages/sign_in_anonymous.dart';
import 'package:todo_list/features/auth/presentation/ui/pages/sign_out.dart';
import 'package:todo_list/features/auth/presentation/ui/pages/sign_up.dart';
import 'package:todo_list/features/todo_list/presentation/ui/pages/string_item_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({super.navigatorKey});
@override
List<AutoRoute> get routes => [
        AutoRoute(page: StringItemRoute.page, initial: true),
        AutoRoute(page: LandingRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SignOutRoute.page),
        AutoRoute(page: SignInAnonymousRoute.page),
      ];

}
