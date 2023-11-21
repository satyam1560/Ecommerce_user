import 'package:ecommerce_user/src/core/features/authentication/presentation/pages/login_screen.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes_constants.dart';

class MyAppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      name: MyAppRouteConstants.loginRouteName,
      path: '/',
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginScreen());
      },
    ),
    GoRoute(
      name: MyAppRouteConstants.signupRouteName,
      path: '/Signup',
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpScreen());
      },
    )
  ]);
}
