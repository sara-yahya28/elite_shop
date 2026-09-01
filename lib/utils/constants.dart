import '../models/product.dart';

const String appName = 'Elite Shop';

// البيانات الوهمية للأقسام
final List<String> categories = [
  'الجمال',
  'الألعاب',
  'المنزل',
  'الرياضة',
  'الموضة',
  'الإلكترونيات',
];

// البيانات الوهمية للمنتجات
final List<Product> mockProducts = [
  Product(
    id: 1,
    name: 'هاتف ذكي',
    description: 'أحدث هاتف مع كاميرا جبارة',
    price: 999.99,
    imageUrl: 'assets/images/phone.png',
  ),
  Product(
    id: 2,
    name: 'حذاء جري رياضي',
    description: 'خفيف ومريح للتمارين اليومية',
    price: 120.50,
    imageUrl: 'assets/images/shoes.png',
  ),
  Product(
    id: 3,
    name: 'سماعة لاسلكية',
    description: 'عزل ضوضاء وجودة صوت عالية',
    price: 89.99,
    imageUrl: 'assets/images/headphones.png',
  ),
  Product(
    id: 4,
    name: 'ساعة ذكية',
    description: 'تتبع اللياقة والصحة',
    price: 249.00,
    imageUrl: 'assets/images/watch.png',
  ),
];

// Shared cart list used by the home page and cart page.
final List<Product> cartItems = [];