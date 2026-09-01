import 'package:flutter/material.dart';
// استيراد flutter_bloc للاتصال بالـ Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
// استيراد نموذج المنتج
import 'package:elite_shop/models/product.dart';
// استيراد FavoritesCubit
import 'package:elite_shop/cubit/favorites/favorites_cubit.dart';

// 🔴 تغيير من StatefulWidget إلى StatelessWidget
// لأن الزر لم يعد يدير حالته بنفسه، بل يستمع إلى الـ Cubit
class FavButton extends StatelessWidget {
  // المنتج المرتبط بهذا الزر (يُمرر من الخارج)
  final Product product;

  const FavButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // 🔍 watch: تستمع إلى FavoritesCubit
    // كلما تغيرت قائمة المفضلات، يُعاد بناء هذا الزر
    final cubit = context.watch<FavoritesCubit>();

    // ✅ نتحقق إذا كان المنتج موجوداً في قائمة المفضلات
    final isLiked = cubit.isFavorite(product);

    return IconButton(
      icon: Icon(
        // إذا كان مفضلاً: قلب أحمر، وإلا: قلب رمادي فارغ
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        // 📢 read: تنفيذ العملية دون الاستماع للتغييرات
        // نضيف أو نزيل المنتج من المفضلات
        context.read<FavoritesCubit>().toggleFavorite(product);
      },
    );
  }
}