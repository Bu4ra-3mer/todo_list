import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_list/core/di/injection.dart' as app_di;
import 'package:todo_list/core/di/injection.dart';
import 'package:todo_list/core/routes/app_router.dart';
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:todo_list/features/todo_list/presentation/cubit/cubit_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log("Step 1 - Binding done", name: "main");

  final keyApplicationId = 'Gjihvt1qXI5oreZGAdh0hlPVIriX31VEs3NuyvWE';
  final keyClientKey = 'DliZpJ8AkFpmSaSd0ygrL88gJ6MWaqTzyV4ryhfa';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );


  await app_di.configureDependencies();
  log("Step 2 - Dependencies configured", name: "main");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubitCubit>()..getCurrentUser()),
        BlocProvider(create: (_) => getIt<StringItemCubit>()),
      ],
      child: MyApp(),
    ),
  );
  log("Step 3 - App launched at ${DateTime.now()}", name: "main");
}



class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}
