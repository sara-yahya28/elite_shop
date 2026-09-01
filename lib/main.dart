import 'package:elite_shop/pages/auth/signin_page.dart';
import 'package:elite_shop/pages/auth/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:elite_shop/utils/theme.dart';
import 'package:elite_shop/pages/auth/login_page.dart';
import 'package:elite_shop/pages/home/home_page.dart';
import 'package:elite_shop/pages/cart/cart_page.dart';
import 'package:elite_shop/pages/profile/profile_page.dart';


import 'package:elite_shop/pages/main/main_screen.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      title: 'Elite Shop',
      theme: appTheme(),
      debugShowCheckedModeBanner: false,

      routes: {
        '/': (context) => const WelcomePage(),
        '/main': (context) => const MainScreen(),
        '/home': (context) => const HomePage(),
        '/cart': (context) => const CartPage(),
        '/signin': (context) => const SigninPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
