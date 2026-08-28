import 'package:elite_shop/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:elite_shop/pages/auth/welcome_page.dart';
import 'package:elite_shop/pages/auth/signin_page.dart';   // تأكد من وجودها
import 'package:elite_shop/pages/home/home_page.dart';     // تأكد من وجودها

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  // define form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // define storage attributed
  String? email;
  String? password;
  bool isLoading = false, isVisible = false, isChecked = false;

  void _submitForm() {
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 10),
              const Text(
                'يجب الموافقة على الأحكام والشروط',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
        ),
      );
      return; // منع المتابعة
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });

      debugPrint("البريد الالكتروني:$email");
      debugPrint(" كلمة المرور:$password");

      // محاكاة ارسال البيانات
      Future.delayed(const Duration(seconds: 2), () {
        // ✅ التحقق من mounted قبل استخدام context
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تسجيل الدخول بنجاح'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('تسجيل الدخول'),
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/elite-store-logo.png',
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
                    const SizedBox(height: 50),

                    // email field
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixText: '@gmail.com',
                        labelText: '  البريد الالكتروني',
                        hintText: 'example@gmail.com',
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'لا يمكنك ترك حق البريد الالكتروني فارغًا';
                        }
                        if (value.length < 5) {
                          return 'البريد الالكتروني قصير جدًا';
                        }
                        return null;
                      },
                      onSaved: (newValue) => email = newValue,
                    ),
                    const SizedBox(height: 20),

                    // password field
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: !isVisible,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        labelText: '   كلمة المرور',
                        hintText: 'أدخل كلمة المرور',
                        prefix: Icon(Icons.lock, color: primaryColor),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب ان تكون 6 احرف على الاقل';
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل (A-Z)';
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل (0-9)';
                        }
                        if (!RegExp(r'[!@#$%^&*(),.?":{}|]').hasMatch(value)) {
                          return 'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل (!@#\$...)';
                        }
                        return null;
                      },
                      onSaved: (newValue) => password = newValue,
                    ),
                    const SizedBox(height: 5),

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
                        const Text(' اوافق على الاحكام و الشروط'),
                      ],
                    ),

                    ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('تسجيل الدخول'),
                    ),
                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('سيتم إضافة صفحة استعادة كلمة المرور قريباً'),
                          ),
                        );
                      },
                      child: const Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ليس لديك حساب؟'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninPage(),
                              ),
                            );
                          },
                          child: const Text(
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
            ],
          ),
        ),
      ),
    );
  }
}