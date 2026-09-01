// استيراد نموذج المنتج
import 'package:elite_shop/models/product.dart';

// كلاس أساسي (abstract) لتمثيل جميع حالات المنتجات
// abstract يعني: لا يمكن إنشاء كائن منه مباشرة، بل نستخدم الكلاسات التي ترث منه
abstract class ProductsState {}

// ✅ الحالة الأولى: قبل البدء بأي شيء (الحالة المبدئية)
class ProductsInitial extends ProductsState {}

// ✅ الحالة الثانية: جاري تحميل البيانات
class ProductsLoading extends ProductsState {}

// ✅ الحالة الثالثة: تم تحميل البيانات بنجاح
class ProductsLoaded extends ProductsState {
  // تحتوي على قائمة المنتجات
  final List<Product> products;
  
  // Constructor (دالة البناء)
  ProductsLoaded(this.products);
}

// ✅ الحالة الرابعة: حدث خطأ
class ProductsError extends ProductsState {
  // تحتوي على رسالة الخطأ
  final String message;
  
  ProductsError(this.message);
}