import 'package:elite_shop/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:elite_shop/pages/auth/login_page.dart';

//import 'package:elite_shop/pages/home/home_page.dart';


// أضيفي هذا الاستيراد فوق في أعلى الملف:
import 'package:elite_shop/pages/main/main_screen.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isChecked = false;

// check sign in
  void _submitForm() {
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'يجب الموافقة على الأحكام والشروط',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
        ),
      );
      return;
    }

// validate input data
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('كلمة المرور وتأكيدها غير متطابقين'),
            backgroundColor: Colors.orange,
          ),
        );
        return; 
      }
      setState(() {
        isLoading = true;
      });

      debugPrint("الاسم الكامل: $fullName");
      debugPrint("البريد الإلكتروني: $email");
      debugPrint("كلمة المرور: $password");

      // 6. محاكاة إرسال البيانات
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إنشاء الحساب بنجاح '),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('إنشاء حساب جديد'),
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(
                    'assets/images/elite-store-logo.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'أنشئ حسابك الآن',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'الاسم الكامل',
                      hintText: 'أدخل اسمك كاملاً',
                      prefixIcon: Icon(Icons.person, color: primaryColor),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الاسم الكامل';
                      }
                      if (value.length < 3) {
                        return 'الاسم قصير جداً (3 أحرف على الأقل)';
                      }
                      return null;
                    },
                    onSaved: (newValue) => fullName = newValue,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      hintText: 'example@gmail.com',
                      prefixIcon: Icon(Icons.email, color: primaryColor),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'الرجاء إدخال بريد إلكتروني صحيح (يحتوي على @ و .)';
                      }
                      return null;
                    },
                    onSaved: (newValue) => email = newValue,
                  ),
                  const SizedBox(height: 20),

                  // 3. كلمة المرور
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: !isPasswordVisible,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      hintText: 'أدخل كلمة مرور قوية',
                      prefixIcon: Icon(Icons.lock, color: primaryColor),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      }
                      if (value.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'يجب أن تحتوي على حرف كبير واحد على الأقل (A-Z)';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'يجب أن تحتوي على رقم واحد على الأقل (0-9)';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|]').hasMatch(value)) {
                        return 'يجب أن تحتوي على رمز خاص واحد على الأقل (!@#\$...)';
                      }
                      return null;
                    },
                    onSaved: (newValue) => password = newValue,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: !isConfirmPasswordVisible,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'تأكيد كلمة المرور',
                      hintText: 'أعد كتابة كلمة المرور',
                      prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء تأكيد كلمة المرور';
                      }
                      // ملاحظة: هذا التحقق قد لا يعمل لأن password لم تُحفظ بعد،
                      // لكننا نتحقق مجدداً في _submitForm بشكل صريح.
                      return null;
                    },
                    onSaved: (newValue) => confirmPassword = newValue,
                  ),
                  const SizedBox(height: 10),

                  // 5. الموافقة على الشروط
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

                  ElevatedButton(
                    onPressed: isLoading ? null : _submitForm,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('إنشاء حساب'),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('لديك حساب بالفعل؟'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}