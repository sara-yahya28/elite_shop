import 'package:elite_shop/pages/auth/login_page.dart';
import 'package:elite_shop/pages/auth/signin_page.dart';
import 'package:elite_shop/utils/theme.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                    'assets/images/elite-store-logo.png',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 5),
            Text(
              ' وجهتك الأولى للتسوق الذكي',
              style: TextStyle(color: textColor),
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
               MaterialPageRoute(builder: (context)=>LoginPage()));
            },
             child: Text('تسجيل الدخول')),
            SizedBox(height: 10),
            ElevatedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryColor),
                backgroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,
                   MaterialPageRoute(builder: (context)=>SigninPage()));
              },
              child: Text('انشاء حساب جديد ',
              style: TextStyle(
                color: textColor),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
