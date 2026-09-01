import 'package:flutter/material.dart';
// استيراد flutter_bloc
import 'package:flutter_bloc/flutter_bloc.dart';
// استيراد FavoritesCubit و FavoritesState
import 'package:elite_shop/cubit/favorites/favorites_cubit.dart';
import 'package:elite_shop/cubit/favorites/favorites_state.dart';
// استيراد ProductCard
import 'package:elite_shop/widgets/product/product_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('المفضلات'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          // 🔍 طباعة تفصيلية للحالة
          print('🟣 FavoritesPage تعيد البناء');
          print('📋 عدد المفضلات في الحالة: ${state.favorites.length}');

          for (var product in state.favorites) {
            print('   - المنتج: ${product.name} (ID: ${product.id})');
          }

          final favorites = state.favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'لا توجد منتجات مفضلة',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price}'),
                leading: Image.network(product.imageUrl, height: 150),
                trailing: const Icon(Icons.favorite, color: Colors.red),
              );
            },
          );
        },
      ),
    );
  }
}
