import '../../models/product.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<Product> items;
  CartUpdated(this.items);
}