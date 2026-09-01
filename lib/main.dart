import 'package:elite_shop/pages/auth/signin_page.dart';
import 'package:elite_shop/pages/auth/welcome_page.dart';
import 'package:elite_shop/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:elite_shop/utils/theme.dart';
import 'package:elite_shop/pages/auth/login_page.dart';
import 'package:elite_shop/pages/home/home_page.dart';
import 'package:elite_shop/pages/cart/cart_page.dart';
import 'package:elite_shop/pages/main/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elite_shop/cubit/products/products_cubit.dart';
import 'package:elite_shop/cubit/favorites/favorites_cubit.dart';
import 'package:elite_shop/cubit/cart/cart_cubit.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ⬇️ لف التطبيق بـ MultiBlocProvider لتوفير الـ Cubits
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit()..fetchProducts()),
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
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
          '/profile': (context) => const ProfilePage(),
        },
      ),
    );
  }
}
