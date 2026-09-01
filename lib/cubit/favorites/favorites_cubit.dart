import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elite_shop/models/product.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

void toggleFavorite(Product product) {
  print('🟡 2. المنتج المراد إضافته:');
  print('   - الاسم: ${product.name}');
  print('   - الـ ID: ${product.id}');
  print('   - السعر: ${product.price}');

  final currentFavorites = state.favorites;
  print('📋 القائمة الحالية تحتوي على: ${currentFavorites.length} منتج');

  final exists = currentFavorites.any((p) => p.id == product.id);
  print('❓ هل المنتج موجود؟ $exists');

  List<Product> newFavorites;
  if (exists) {
    newFavorites = currentFavorites.where((p) => p.id != product.id).toList();
    print('🗑️ تمت إزالة المنتج');
  } else {
    newFavorites = [...currentFavorites, product];
    print('➕ تمت إضافة المنتج');
  }

  print('📊 القائمة الجديدة تحتوي على: ${newFavorites.length} منتج');
  emit(state.copyWith(favorites: newFavorites));
}
  bool isFavorite(Product product) {
    return state.favorites.any((p) => p.id == product.id);
  }
}