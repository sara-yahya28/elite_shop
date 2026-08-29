import 'package:elite_shop/utils/theme.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
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
    final double cartTotal = cartItems.fold(
      0.0,
      (sum, item) => sum + item.price,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('سلة التسوق'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //المنتجات في السلة
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
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final product = cartItems[index];

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 16,
                    ),
                    leading: Image.asset(
                      product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 30,
                          color: Colors.red,
                        );
                      },
                    ),
                    title: Text(product.name),
                    subtitle: Text(product.price.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            //اختيار طريقة الشحن
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
                      title: const Text('شحن عادي '),
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
                    Divider(),
                    RadioListTile<String>(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      title: const Text('شحن سريع '),
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
          ],
        ),
      ),

      //BottomAppBar
      bottomNavigationBar: BottomAppBar(
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
                Text('المجموع الكلي'),
                SizedBox(height: 10),
                // Use the current shared cart list so the total updates immediately.
                Text(
                  cartTotal.toStringAsFixed(2),
                  style: TextStyle(
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
                                  child: const Text('إالغاء الأمر'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/home',
                                      (route) => false,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.lightGreen,
                                            ),
                                            const SizedBox(width: 8),
                                            Text('تمت عملية الدفع بنجاح'),
                                          ],
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    );
                                    //العودة للصفحة الرئيسي
                                  },
                                  child: Text('تأكيد الدفع'),
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
  }
}
