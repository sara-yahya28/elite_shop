import 'package:flutter/material.dart';
import 'package:elite_shop/utils/theme.dart';
import 'package:elite_shop/pages/auth/signin_page.dart';
import 'package:elite_shop/widgets/common/custom_button.dart';
import 'package:elite_shop/pages/main/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elite_shop/cubit/login/login_cubit.dart';
import 'package:elite_shop/cubit/login/login_state.dart';
import 'package:elite_shop/services/user_session.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller لاسم المستخدم
  final TextEditingController _usernameController =
      TextEditingController();

  // Controller لكلمة المرور
  final TextEditingController _passwordController =
      TextEditingController();

  bool isVisible = false;
  bool isChecked = false;

  // إرسال بيانات تسجيل الدخول
  void _submitForm(BuildContext context) {
    // التحقق من الموافقة على الشروط
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'يجب الموافقة على الأحكام والشروط',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      // إرسال اسم المستخدم وكلمة المرور إلى LoginCubit
      context.read<LoginCubit>().login(
            _usernameController.text,
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),

      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // إذا نجح تسجيل الدخول
          if (state is LoginSuccess) {
            UserSession.saveUser(state.user);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تسجيل الدخول بنجاح'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          }

          // إذا فشل تسجيل الدخول
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },

        builder: (context, state) {
          // نحدد هل الـ Login قيد التنفيذ
          final bool isLoading = state is LoginLoading;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: const Text('تسجيل الدخول'),
            ),

            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: 350,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // الشعار
                        Image.asset(
                          'assets/images/elite-store-logo.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'مرحبًا بك مجددًا',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // حقل اسم المستخدم
                        TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'اسم المستخدم',
                            hintText: 'أدخل اسم المستخدم',
                            prefixIcon: Icon(
                              Icons.person,
                              color: primaryColor,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال اسم المستخدم';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // حقل كلمة المرور
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !isVisible,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            hintText: 'أدخل كلمة المرور',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: primaryColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: secondryColor,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        // الموافقة على الشروط
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isChecked = newValue ?? false;
                                });
                              },
                              activeColor: secondryColor,
                              checkColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const Text('أوافق على الأحكام والشروط'),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // زر تسجيل الدخول
                        CustomButton(
                          text: isLoading
                              ? 'جاري تسجيل الدخول...'
                              : 'تسجيل الدخول',
                          onPressed: () {
                            if (!isLoading) {
                              _submitForm(context);
                            }
                          },
                        ),

                        const SizedBox(height: 10),

                        // نسيت كلمة المرور
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'سيتم إضافة صفحة استعادة كلمة المرور قريباً',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),

                        // رابط إنشاء حساب جديد
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('ليس لديك حساب؟'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SigninPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'إنشاء حساب جديد',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}