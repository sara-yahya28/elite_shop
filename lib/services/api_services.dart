// استيراد مكتبة Dio للاتصال بالإنترنت
import 'package:dio/dio.dart';

// تعريف كلاس ApiService
class ApiService {
  // متغير من نوع Dio، سيتم تهيئته لاحقاً (late يعني سيأتي لاحقاً)
  late Dio _dio;

  // Constructor (دالة البناء) - تُنفذ عند إنشاء كائن من ApiService
  ApiService() {
    // إعدادات الاتصال الأساسية
    BaseOptions options = BaseOptions(
      // الرابط الأساسي للسيرفر
      baseUrl: 'https://dummyjson.com',
      
      // مهلة الاتصال: إذا لم يستجب السيرفر خلال 5 ثوانٍ، يعتبر فشل
      connectTimeout: const Duration(seconds: 5),
      
      // مهلة الاستلام: إذا لم يكمل السيرفر إرسال البيانات خلال 5 ثوانٍ
      receiveTimeout: const Duration(seconds: 5),
      
      // الرؤوس (Headers): بطاقة تعريف تُرسل مع كل طلب
      headers: {
        'Accept': 'application/json',      // أريد استلام البيانات بصيغة JSON
        'Content-Type': 'application/json', // أرسل البيانات بصيغة JSON
      },
    );
    
    // تهيئة Dio بهذه الإعدادات
    _dio = Dio(options);
  }

  // دالة لجلب جميع المنتجات
  // Future تعني "وعد": ستعيد قائمة لاحقاً (بعد تحميل البيانات)
  // async تعني: هذه الدالة غير متزامنة، قد تنتظر شيئاً
  Future<List<dynamic>> getAllProducts() async {
    try {
      // await: انتظري هنا حتى يجيب السيرفر، ولا توقفي بقية التطبيق
      // _dio.get('/products') ترسل طلب GET إلى الرابط: https://dummyjson.com/products
      Response response = await _dio.get('/products');
      
      // statusCode 200 يعني نجاح الطلب
      if (response.statusCode == 200) {
        // البيانات تأتي مغلفة: {"products": [...]}
        // لذا نستخرج المصفوفة من المفتاح 'products'
        List<dynamic> productsList = response.data['products'];
        
        // نطبع عدد المنتجات في الـ Console (للتأكد)
        print('✅ تم جلب ${productsList.length} منتج');
        
        // نعيد القائمة
        return productsList;
      }
      
      // إذا لم يكن الكود 200، نعيد قائمة فارغة
      return [];
      
    } on DioException catch (e) {
      // في حالة حدوث خطأ (انقطاع النت، مشكلة في السيرفر...)
      // نطبع رسالة الخطأ
      print('⚠️ خطأ: ${e.message}');
      
      // نعيد قائمة فارغة
      return [];
    }
  }
// دالة الـ login
Future<Map<String, dynamic>> login(
  String username,
  String password,
) async {
  try {
    print('🔵 إرسال بيانات تسجيل الدخول...');
    print('Username: $username');
    print('Password: $password');

    final response = await _dio.post(
      '/user/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    print('🟢 Response Status: ${response.statusCode}');
    print('🟢 Response Data: ${response.data}');

    if (response.statusCode == 200) {
      return response.data;
    }

    return {};
  } on DioException catch (e) {
    print('🔴 Login Error: ${e.message}');
    print('🔴 Status Code: ${e.response?.statusCode}');
    print('🔴 Response: ${e.response?.data}');

    return {};
  }
}


}