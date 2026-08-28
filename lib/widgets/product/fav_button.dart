import 'package:flutter/material.dart';

//StatefulWidget لان الزر تفاعلي
class FavButton extends StatefulWidget {
  const FavButton({super.key});

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  // قيمة افتراضية للزر
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    // ايقونه قابلة للضغط
    return IconButton(
      // ايقونه القلب , اذا كان ترو يحط قلب احمر , واذا كان فولس يعرض قلب رمادي الحواف
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
      // عند الضغط بيتم عكس القيمة الحالية ويعيد تنسيقه
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
    );
  }
}