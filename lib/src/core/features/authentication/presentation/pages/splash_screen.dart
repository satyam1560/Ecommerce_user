import 'package:ecommerce_user/src/core/features/display_products/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../routes/app_routes_constants.dart';
import '../bloc/auth/authentication_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          GoRouter.of(context)
              .pushReplacementNamed(MyAppRouteConstants.loginRouteName);
        } else if (state.authStatus == AuthStatus.authenticated) {
          print('--authenticated--');
          GoRouter.of(context)
              .pushReplacementNamed(MyAppRouteConstants.homeRouteName);
        }
      },
      child: const HomeScreen(),
    );
  }
}
