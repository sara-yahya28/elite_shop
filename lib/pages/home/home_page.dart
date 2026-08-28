import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';
import '../../widgets/product/product_card.dart';
import 'home_widgets/category_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // دالة لعرض تفاصيل المنتج داخل BottomSheet عند الضغط على الكرت
  void _showProductDetails(BuildContext context, dynamic product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      //محتوى النافذة السفلية BottomSheet
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          //لترتيب المحتوى بشكل عمودي
          child: Column(
            mainAxisSize: MainAxisSize.min, //تخلي ارتفاع النافذة يتناسب مع المحتوى
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // خط صغير اعلى منتصف النافذة لسحبها للاسفل
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // اسم المنتج
              Text(
                product.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // وصف المنتج
              Text(
                product.description,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 12),
              // سعر المنتج
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              // زر الإضافة إلى السلة
              SizedBox(
                width: double.infinity, // ياخذ عرض كامل النافذة
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  //عند الضغط على الزر، يتم إغلاق النافذة وعرض رسالة SnackBar
                  onPressed: () {
                    Navigator.pop(ctx);
                    //اشعار اسفل الشاشة
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم إضافة ${product.name} إلى السلة!'),
                        backgroundColor: primaryColor,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('أضف إلى السلة'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //عنصر لمنع ظهور نص توضيحي عند تمرير الماوس  
    return TooltipVisibility(
      visible: false, 
      //الهيكل الاساسي للصفحة
      child: Scaffold(
        backgroundColor: backgroundColor, 

        appBar: AppBar(
          title: const Text(appName),
          centerTitle: true,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          actions: [
            //ايقونة البحث , غير مفعلة
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            //ايقونه السلة
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
          ],
        ),

        // القائمة الجانبية
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              //راس القائمة الجانبية
              UserAccountsDrawerHeader(
                accountName: const Text(
                  'Noora',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                accountEmail: const Text('noora@gmail.com'),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'N',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                //خلفية الراس
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('الرئيسية'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('السلة'),
                onTap: () {
                  //يغلق القائمة الجانبية
                  Navigator.pop(context);
                  //ينتقل لصفحة السلة
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ],
          ),
        ),

        // لتمرير الصفحة بشكل عمودي
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // الشريط الاعلاني بداية الصفحة
              SizedBox(
                height: 80,
                //عنصر يسمح بعرض بطاقات يمكن تمريرها بشكل افقي
                child: CarouselView(
                  itemExtent: 250, //عرض العنصر الواحد
                  shrinkExtent: 200, //تحدد مدى صغر البطاقة عند السحب وتعطي تاثير للحركة
                  //مصفوفة للاعلانات 
                  children: [
                    Container(
                      color: primaryColor,
                      child: const Center(
                        child: Text(
                          '! عروض الصيف ',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      color: secondryColor,
                      child: const Center(
                        child: Text(
                          'خصم 50% على الأحذية',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      color: primaryColor,
                      child: const Center(
                        child: Text(
                          '! جديدنا: الإلكترونيات ',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      color: secondryColor,
                      child: const Center(
                        child: Text(
                          '! منتجات حصرية ',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //استدعاء صفحة الاقسام CategorySection
              const CategorySection(),

              const SizedBox(height: 10),

              // قسم المنتجات
              const Padding(
                //مسافات حول النص
                padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0, bottom: 8.0),
                //لمحاذاة النص في المنتصف
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'أحدث المنتجات',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // جعل العناصر تتجاوب مع الحجم
              Padding(
                //مسافة متساوي للجانبين لمنع الكروت من الالتصاق بحواف الشاشة
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //عنصر يقرا مساحة الشاشة الحالية تنعطى عبر ال constraints
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // شرط اذا كانت المساحة اكبر من 600 بكسل يعرض بشكل GridView
                    if (constraints.maxWidth > 600) {
                      return GridView.builder(
                        shrinkWrap: true,//تخلي العناصر تاخذ مساحة عمودية حسب المحتوى
                        physics: const NeverScrollableScrollPhysics(),//توقف التمرير الخاص عشان لا يتضارب مع تمرير الصفحة الرئيسية
                        //هيكل وتقسيم العناصر في الشبكة
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        //عدد العناصر حسب العناصر الوهمية المضافة في ملف constants.dart 
                        itemCount: mockProducts.length,
                        //يبني الكرت وياخذ البيانات حسب ترقيمه
                        itemBuilder: (context, index) {
                          final product = mockProducts[index];
                          return ProductCard(
                            product: product,
                            //عند الضغط على الكرت يتم استدعاء دالة عرض تفاصيل المنتج
                            onTap: () => _showProductDetails(context, product),
                          );
                        },
                      );
                      //شرط اذا كانت المساحة اقل من 600 يعرض بشكل ListView
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mockProducts.length,
                        itemBuilder: (context, index) {
                          final product = mockProducts[index];
                          return Padding(
                            //مسافة اسفل كل كرت
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              //ارتفاع الكرت
                              height: 280,
                              child: ProductCard(
                                product: product,
                                onTap: () => _showProductDetails(context, product),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}