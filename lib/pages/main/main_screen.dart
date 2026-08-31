import 'package:flutter/material.dart';
import 'package:elite_shop/utils/theme.dart';
import 'package:elite_shop/pages/home/home_page.dart';
import 'package:elite_shop/pages/cart/cart_page.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  // التبويبات الرئيسية داخل المتجر
  final List<Widget> _pages = const [
    HomePage(), // التبويب 0: الرئيسية
    Center(child: Text('المفضلة')), // التبويب 1: المفضلة
    CartPage(), // التبويب 2: السلة (الصفحة الحقيقية)
    Center(child: Text('حسابي')), // التبويب 3: الحساب
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: TooltipVisibility(
          visible: false, // 👈 لإلغاء ظهور النص/التلميح التوضيحي فوق الأيقونات
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            indicatorColor: primaryColor.withOpacity(0.15),
            elevation: 0,
            height: 65,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: primaryColor),
                label: 'الرئيسية',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite, color: primaryColor),
                label: 'المفضلة',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart, color: primaryColor),
                label: 'السلة',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: primaryColor),
                label: 'حسابي',
              ),
            ],
          ),
        ),
      ),
    );
  }
}