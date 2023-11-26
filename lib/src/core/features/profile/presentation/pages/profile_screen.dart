import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../routes/app_routes_constants.dart';
import '../../../authentication/presentation/bloc/auth/authentication_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignoutRequestedEvent());
                GoRouter.of(context)
                    .goNamed(MyAppRouteConstants.loginRouteName);
              },
              child: const Text('Log Out')),
        ),
      ),
    );
  }
}
