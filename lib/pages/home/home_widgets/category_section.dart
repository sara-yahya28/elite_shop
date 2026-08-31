import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/theme.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة الايقونات الخاصة بالاقسام
    final List<IconData> categoryIcons = [
      Icons.face,       
      Icons.sports_esports, 
      Icons.home,          
      Icons.sports_soccer,  
      Icons.checkroom,      
      Icons.devices,           
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان قسم الأقسام
        const Padding(
          //مسافات حول النص
          padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0, bottom: 8.0),
          //لمحاذاة النص بالمنتصف
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'الأقسام',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // حاوية الاقسام
        Container(
          //مساحة من الجهتين لمنع الالتصاق بحواف الشاشة
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity, //تاخذ العرض المتاح للشاشة
          //عنصر يسمح بالتمرير الأفقي
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(), // يعطي تأثير مرن عند انتهاء التمرير
            child: Row(
              // دالة لتوليد العناصر حسب الموجود بالقائمة categories
              children: List.generate(categories.length, (index) {
                //يعرض الايقونه والاسم بشكل عمودي
                return Padding(
                  padding: const EdgeInsets.all( 10.0), // مسافة بين كل قسم والآخر
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // دائرة الايقونه
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.12), // خلفية شفافة بلون الثيم
                          shape: BoxShape.circle, // شكل دائري
                          border: Border.all(
                            color: primaryColor.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                        //يعرض الايقونات حسب الترتيب في القائمة categoryIcons
                        child: Icon(
                          index < categoryIcons.length ? categoryIcons[index] : Icons.category,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // اسم القسم تحت الدائرة
                      Text(
                        categories[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}