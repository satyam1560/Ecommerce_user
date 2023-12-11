import 'package:ecommerce_user/src/core/features/authentication/presentation/pages/login_screen.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/pages/signup_screen.dart';
import 'package:ecommerce_user/src/core/features/authentication/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/core/features/display_products/presentation/pages/home_page.dart';
import '../src/core/features/my_orders/presentation/pages/my_order_screen.dart';
import 'app_routes_constants.dart';

class MyAppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      name: MyAppRouteConstants.splashRouteName,
      path: '/',
      pageBuilder: (context, state) {
        return const MaterialPage(child: SplashPage());
      },
    ),
    GoRoute(
      name: MyAppRouteConstants.loginRouteName,
      path: '/Signin',
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
    ),
    GoRoute(
      name: MyAppRouteConstants.homeRouteName,
      path: '/Home',
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomeScreen());
      },
    ),
    GoRoute(
      name: MyAppRouteConstants.myOrderRouteName,
      path: '/myOrder',
      pageBuilder: (context, state) {
        return const MaterialPage(child: MyOrderScreen());
      },
    ),
  ]);
}
