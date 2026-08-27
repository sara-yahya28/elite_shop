import 'package:flutter/material.dart';
import '../models/product.dart';

const String appName = 'Elite Shop';

// البيانات الوهمية للأقسام
final List<String> categories = [
  'الإلكترونيات',
  'الألعاب',
  'المنزل',
  'الرياضة',
  'الموضة',
  'الجمال'
];

// البيانات الوهمية للمنتجات
final List<Product> mockProducts = [
  const Product(
    id: 1,
    name: 'هاتف ذكي',
    description: 'أحدث هاتف مع كاميرا جبارة',
    price: 999.99,
    imageUrl: 'https://via.placeholder.com/150/008080/FFFFFF?text=Phone',
  ),
  const Product(
    id: 2,
    name: 'حذاء جري رياضي',
    description: 'خفيف ومريح للتمارين اليومية',
    price: 120.50,
    imageUrl: 'https://via.placeholder.com/150/FF8C00/FFFFFF?text=Running+Shoes',
  ),
  const Product(
    id: 3,
    name: 'سماعة لاسلكية',
    description: 'عزل ضوضاء وجودة صوت عالية',
    price: 89.99,
    imageUrl: 'https://via.placeholder.com/150/4B0082/FFFFFF?text=Headphones',
  ),
  const Product(
    id: 4,
    name: 'ساعة ذكية',
    description: 'تتبع اللياقة والصحة',
    price: 249.00,
    imageUrl: 'https://via.placeholder.com/150/FF6347/FFFFFF?text=Watch',
  ),
];