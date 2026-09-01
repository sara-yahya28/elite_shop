import 'package:elite_shop/models/product.dart';

class FavoritesState {
  final List<Product> favorites;
  const FavoritesState({this.favorites = const []});
  FavoritesState copyWith({List<Product>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }
}