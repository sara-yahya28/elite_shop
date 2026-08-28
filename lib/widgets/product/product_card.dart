import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'fav_button.dart';
import '../../utils/theme.dart';

class ProductCard extends StatelessWidget {
  // يحتوي على كل معلومات المنتج
  final Product product;
  //دالة تنفذ عند الضغط على الكرت
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // يخلي الكرت كله قابل للضغط
    return InkWell(
      //ربط ضغطة الكارت بالدالة اللي بتنفذعند الضغط
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 4, // درجة الظل وتجسيم البطاقة
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // حواف دائرية للبطاقة
        ),
        //  لوضع زر الإعجاب فوق صورة المنتج
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //تجعل الصورة تمتد وتاخذ المساحة المتبقية اعلى الكرت
                 Expanded(
                  //تقص حواف الصورة لتكون دائرية من الاعلى فقط
  child: ClipRRect(
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(15),
    ),
    //لعرض الصور 
    child: Image.asset(
      product.imageUrl,
      width: double.infinity,
      fit: BoxFit.contain,
      //اذا حدث مشكلة بعرض الصورة يعرض رسالة خطأ بدل ما ينهار التطبيق
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[200],
          width: double.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, color: Colors.grey, size: 30),
              SizedBox(height: 4),
              Text('المسار غير صحيح', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        );
      },
    ),
  ),
),
                
                // تفاصيل المنتج الاسم والوصف والسعر
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اسم المنتج 
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      
                      // وصف المنتج
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // السعر
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            //  زر الإعجاب  FavButton  
            const Positioned(
              top: 5,
              right: 5,
              child: FavButton(),
            ),
          ],
        ),
      ),
    );
  }
}