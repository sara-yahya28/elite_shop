import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  // دالة حساب الإجمالي: تمر على كل المنتجات وتضرب السعر في الكمية
  double calculateTotalPrice() {
    double total = 0.0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  // دالة التحديث العامة التي تنبه الواجهة (UI) بالتغييرات
  void _updateCartState() {
    emit(CartUpdated(List.from(_items)));
  }

  // دالة الإضافة: إذا كان المنتج موجوداً تزيد كميته، وإذا لم يكن موجوداً تضيفه للسلة
  void addToCart(Product product) {
    int index = _items.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      _items[index].quantity++;
    } else {
      // التأكد من بدء الكمية بـ 1 عند الإضافة لأول مرة
      product.quantity = 1;
      _items.add(product);
    }
    _updateCartState();
  }

  // دالة زيادة الكمية (+)
  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      _updateCartState();
    }
  }

  // دالة نقصان الكمية (-): ينقص حبة إذا كانت > 1، ويحذف العنصر إذا كانت = 1
  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      _updateCartState();
    }
  }

  // دالة الحذف المباشر
  void removeFromCart(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      _updateCartState();
    }
  }

  // دالة تفريغ السلة بعد الدفع
  void clearCart() {
    _items.clear();
    _updateCartState();
  }
}