import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elite_shop/utils/theme.dart';
import 'package:elite_shop/cubit/cart/cart_cubit.dart';
import 'package:elite_shop/cubit/cart/cart_state.dart';
import '../../widgets/common/custom_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _selectedShipping = 'standard';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final cartItems = cartCubit.items;
        final double cartTotal = cartCubit.calculateTotalPrice();

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('سلة التسوق'),
            backgroundColor: primaryColor,
          ),
          body: cartItems.isEmpty
              ? const Center(
                  child: Text(
                    'السلة فارغة حالياً',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'المنتجات',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: cartItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = cartItems[index];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  // صورة المنتج
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      product.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.broken_image,
                                          size: 40,
                                          color: Colors.grey,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // تفاصيل المنتج
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // التحكم بالكمية (+ -)
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          cartCubit.decrementQuantity(index);
                                        },
                                      ),
                                      Text(
                                        '${product.quantity}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline),
                                        color: Colors.green,
                                        onPressed: () {
                                          cartCubit.incrementQuantity(index);
                                        },
                                      ),
                                    ],
                                  ),
                                  // زر الحذف المباشر
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.grey),
                                    onPressed: () {
                                      cartCubit.removeFromCart(index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'طريقة الشحن',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          child: Column(
                            children: [
                              RadioListTile<String>(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                title: const Text('شحن عادي'),
                                subtitle: const Text('توصيل خلال 5 أيام'),
                                activeColor: primaryColor,
                                value: 'standard',
                                groupValue: _selectedShipping,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedShipping = value!;
                                  });
                                },
                              ),
                              const Divider(),
                              RadioListTile<String>(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                title: const Text('شحن سريع'),
                                subtitle: const Text('توصيل خلال يومين'),
                                activeColor: primaryColor,
                                value: 'express',
                                groupValue: _selectedShipping,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedShipping = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
          bottomNavigationBar: cartItems.isEmpty
              ? null
              : BottomAppBar(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  height: 100,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('المجموع الكلي'),
                          const SizedBox(height: 5),
                          Text(
                            '\$${cartTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 140,
                        child: CustomButton(
                          text: 'ادفع الآن',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      Icon(Icons.help, size: 50, color: primaryColor),
                                      const SizedBox(height: 10),
                                      const Text('تأكيد الدفع'),
                                    ],
                                  ),
                                  content: const Text(
                                    'هل أنت متأكد من رغبتك في إتمام عملية الدفع',
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('إلغاء الأمر'),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              context.read<CartCubit>().clearCart();
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/main',
                                                (route) => false,
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: const Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        color: Colors.lightGreen,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text('تمت عملية الدفع بنجاح'),
                                                    ],
                                                  ),
                                                  behavior: SnackBarBehavior.floating,
                                                  margin: const EdgeInsets.all(16),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text('تأكيد الدفع'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}