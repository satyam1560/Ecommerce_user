import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/routes/app_routes_configuration.dart';
import 'package:ecommerce_user/src/core/features/authentication/data/datasources/auth_repo.dart';
import 'package:ecommerce_user/src/core/features/display_products/presentation/bloc/display_product_bloc/display_products_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/features/authentication/presentation/bloc/auth/authentication_bloc.dart';
import 'src/core/features/authentication/presentation/bloc/signin/signin_cubit.dart';
import 'src/core/features/authentication/presentation/bloc/signup/signup_cubit.dart';
import 'src/core/features/cart/presentation/bloc/cart_bloc.dart';
import 'src/core/features/display_products/presentation/bloc/add_to_car_bloc/add_to_cart_bloc.dart';
import 'src/core/features/my_orders/presentation/bloc/my_orders_bloc.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: FirebaseAuth.instance),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<DisplayProductsBloc>(
            create: (context) => DisplayProductsBloc(
                // authRepository: context.read<AuthRepository>(),
                ),
          ),
          BlocProvider<AddToCartBloc>(
            create: (context) => AddToCartBloc(),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(),
          ),
          BlocProvider<MyOrdersBloc>(
            create: (context) => MyOrdersBloc(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          routerConfig: MyAppRouter().router,
        ),
      ),
    );
  }
}
