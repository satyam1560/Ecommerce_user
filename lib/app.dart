import 'package:ecommerce_user/routes/app_routes_configuration.dart';
import 'package:flutter/material.dart';

import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      routerConfig: MyAppRouter().router,
    );
  }
}
