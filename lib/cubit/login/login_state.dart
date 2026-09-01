// الحالة الأساسية لتسجيل الدخول
abstract class LoginState {}

// الحالة المبدئية
class LoginInitial extends LoginState {}

// أثناء إرسال بيانات تسجيل الدخول
class LoginLoading extends LoginState {}

// تسجيل الدخول نجح
class LoginSuccess extends LoginState {
  //في حالة النجاح يحمل بيانات المستخدم
  final Map<String, dynamic> user;

  LoginSuccess(this.user);
}

// تسجيل الدخول فشل
class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}