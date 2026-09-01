import 'package:elite_shop/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:elite_shop/widgets/profile/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة المستخدم
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 60),
              ),
            ),

            const SizedBox(height: 15),
            // اسم المستخدم
            const Text(
              'نورة صالح',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 5),
            // البريد الإلكتروني
            const Text('noorah.saleh@example.com'),
            const SizedBox(height: 25),
            // إحصائيات المستخدم

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // المفضلة
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE7F6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text('18'),
                            const Text('المفضلة'),
                          ],
                        ),
                      ),
                      //فاصل افقي بين الاحصائيات
                      const VerticalDivider(thickness: 1),

                      // الطلبات
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0F2F1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.shopping_bag,
                                color: Colors.teal,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text('12'),
                            const Text('الطلبات'),
                          ],
                        ),
                      ),
                      const VerticalDivider(thickness: 1),
                      // العناوين
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE7F6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text('3'),
                            Text('العناوين'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'حسابي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const ProfileMenuItem(
                      icon: Icons.person,
                      title: 'المعلومات الشخصية',
                    ),

                    const Divider(height: 1),

                    const ProfileMenuItem(
                      icon: Icons.lock,
                      title: 'تغيير كلمة المرور',
                    ),

                    const Divider(height: 1),

                    const ProfileMenuItem(
                      icon: Icons.notifications,
                      title: 'الإشعارات',
                    ),

                    const Divider(height: 1),

                    const ProfileMenuItem(
                      icon: Icons.language,
                      title: 'اللغة',
                      trailingText: 'العربية',
                    ),

                    const Divider(height: 1),

                    const ProfileMenuItem(
                      icon: Icons.help_outline,
                      title: 'المساعدة والدعم',
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // تسجيل الخروج لاحقًا
                  },
                  icon: const Icon(Icons.logout, color: Colors.red, size: 20),
                  label: const Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF1F1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.red.shade100),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
