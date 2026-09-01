import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elite_shop/cubit/products/products_cubit.dart';
import 'package:elite_shop/cubit/products/products_state.dart';
import 'package:elite_shop/cubit/cart/cart_cubit.dart';
import 'package:elite_shop/models/product.dart';
import 'package:elite_shop/pages/main/main_screen.dart'; // <--- استيراد ملف main_screen هنا
import '../../utils/constants.dart';
import '../../utils/theme.dart';
import '../../widgets/product/product_card.dart';
import 'home_widgets/category_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showProductDetails(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                product.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // إضافة إلى السلة عبر CartCubit
                    context.read<CartCubit>().addToCart(product);
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم إضافة ${product.name} إلى السلة!'),
                        backgroundColor: primaryColor,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('أضف إلى السلة'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            appName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/elite-store-logo.png',
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.storefront, size: 28);
              },
            ),
          ),
         actions: [
  IconButton(
    icon: const Icon(Icons.search),
    onPressed: () {},
  ),
  IconButton(
    icon: const Icon(Icons.shopping_cart),
    onPressed: () {
      // الحصول على حالة MainScreen والتحويل إلى تبويب السلة (Index 2)
      final mainState = context.findAncestorStateOfType<MainScreenState>();
      if (mainState != null) {
        mainState.changeTab(2);
      } else {
        Navigator.pushNamed(context, '/cart');
      }
    },
  ),
],
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            if (state is ProductsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    Text('فشل التحميل: ${state.message}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductsCubit>().fetchProducts();
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is ProductsLoaded) {
              final products = state.products;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: CarouselView(
                        itemExtent: 400,
                        shrinkExtent: 200,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/show.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                ' عروض الصيف ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/phone.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'خصم 50% على الأحذية',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 58, 56, 56),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CategorySection(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'أحدث المنتجات',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 350) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 5,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: products.length, // ✅ إرجاع عدد العناصر الصحيح
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return ProductCard(
                                  product: product,
                                  onTap: () => _showProductDetails(context, product),
                                );
                              },
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: SizedBox(
                                    height: 280,
                                    child: ProductCard(
                                      product: product,
                                      onTap: () => _showProductDetails(context, product),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }

            return const Center(child: Text('لا توجد منتجات'));
          },
        ),
      ),
    );
  }
}