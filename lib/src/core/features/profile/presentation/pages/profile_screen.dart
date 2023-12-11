import 'package:ecommerce_user/src/core/features/my_orders/presentation/pages/my_order_screen.dart';
import 'package:ecommerce_user/src/core/features/profile/data/datasources/user_repo.dart';
import 'package:ecommerce_user/src/core/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../routes/app_routes_constants.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../authentication/presentation/bloc/auth/authentication_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Userrepo userrepo = Userrepo();
  UserModel? user;
  String? authUserId;

  @override
  void initState() {
    authUserId = BlocProvider.of<AuthBloc>(context, listen: false)
        .authRepository
        .currentUserId;
    super.initState();
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    user = await userrepo.getuserdetils(userId: authUserId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.md),
              Text(
                user!.fullName!,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(user!.email!),
              const SizedBox(height: TSizes.sm),
              GestureDetector(
                onTap: () {
                  // Navigate to MyOrderScreen when tapped
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const MyOrderScreen(), // Remove the curly braces here
                    ),
                  );
                },
                child: const Card(
                  child: ListTile(
                    title: Text('My Orders'),
                    subtitle: Text('Already have 12 orders'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.sm),
              const Card(
                child: ListTile(
                  title: Text('Shipping Address'),
                  subtitle: Text('3 addresses'),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.buttonWidth),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(SignoutRequestedEvent());
                        GoRouter.of(context)
                            .goNamed(MyAppRouteConstants.loginRouteName);
                      },
                      child: const Text('Log Out')),
                ),
              ),
            ],
          ),
        ));
  }
}
