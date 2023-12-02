import 'package:ecommerce_user/src/core/features/authentication/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../display_products/presentation/pages/home_page.dart';
import '../bloc/auth/authentication_bloc.dart';

// class SplashPage extends StatelessWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state.authStatus == AuthStatus.unauthenticated) {
//           GoRouter.of(context)
//               .pushReplacementNamed(MyAppRouteConstants.loginRouteName);
//         } else if (state.authStatus == AuthStatus.authenticated) {
//           print('--authenticated--');
//           GoRouter.of(context)
//               .pushReplacementNamed(MyAppRouteConstants.homeRouteName);
//         }
//       },
//       child: const LoginScreen(),
//       //  builder: (context, state) {
//       //   if (state.authStatus == AuthState.unknown()) {
//       //     return const SignUpScreen();
//       //   }
//       // return const LoginScreen();
//     );
//   }
// }
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          return const LoginScreen();
        } else if (state.authStatus == AuthStatus.authenticated) {
          return const HomeScreen();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
