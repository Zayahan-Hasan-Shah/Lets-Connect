import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(appRouterProvider);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'Let\'s Connect',
          routerConfig: router,
        );
      },
    );
  }
}
