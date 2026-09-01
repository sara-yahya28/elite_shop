// استيراد مكتبة flutter_bloc لإدارة الحالة
import 'package:flutter_bloc/flutter_bloc.dart';

// استيراد نموذج المنتج
import 'package:elite_shop/models/product.dart';

// استيراد خدمة API
import 'package:elite_shop/services/api_services.dart';

// استيراد حالات المنتجات
import 'products_state.dart';

// تعريف ProductsCubit: يمتد من Cubit<ProductsState>
// يعني: هذا الـ Cubit يدير حالات من نوع ProductsState
class ProductsCubit extends Cubit<ProductsState> {
  
  // Constructor: نمرر الحالة المبدئية (ProductsInitial)
  ProductsCubit() : super(ProductsInitial());
  
  // مرجع لخدمة API
  final ApiService _apiService = ApiService();

  // دالة لجلب المنتجات
  // Future<void> تعني: هذه الدالة غير متزامنة ولا تعيد قيمة (فقط تنفذ)
  Future<void> fetchProducts() async {
    // 1️⃣ نُصدر حالة التحميل
    // emit() تعني: أصدر هذه الحالة، وأخبر الصفحات التي تستمع
    emit(ProductsLoading());
    
    try {
      // 2️⃣ نطلب البيانات من API
      final data = await _apiService.getAllProducts();
      
      // 3️⃣ نحول البيانات من Map إلى نموذج Product
      List<Product> products = data.map<Product>((json) {
        return Product(
          id: json['id'] ?? 0,                    // إذا لم يوجد، استخدم 0
          name: json['title'] ?? 'بدون عنوان',     // إذا لم يوجد، استخدم هذا النص
          description: json['description'] ?? 'بدون وصف',
          price: (json['price'] ?? 0).toDouble(),
          imageUrl: json['thumbnail'] ?? '',
        );
      }).toList();
      
      // 4️⃣ نُصدر حالة النجاح مع قائمة المنتجات
      emit(ProductsLoaded(products));
      
    } catch (e) {
      // 5️⃣ في حالة الخطأ، نُصدر حالة الخطأ مع رسالة الخطأ
      emit(ProductsError(e.toString()));
    }
  }
}